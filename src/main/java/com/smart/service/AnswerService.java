package com.smart.service;

import com.smart.dao.AnswerDao;
import com.smart.dao.MainDao;
import com.smart.domain.Answer;
import com.smart.domain.Main;
import com.smart.domain.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class AnswerService {
    @Autowired
    @Qualifier("answerDao")
    private AnswerDao answerDao;

    @Autowired
    @Qualifier("mainDao")
    private MainDao mainDao;

    //通过answerId查询答案
    public Answer selectAnswerById(Integer answerId){
        return answerDao.selectAnswerById(answerId);
    }
    //修改问卷回答人数及答案被点击的次数****quesId数组保存答案id
    @Transactional
    public  void updateApplyValues(List<String> answerId){
        for(int i=0;i<answerId.size();i++){
               Answer answer=  answerDao.selectAnswerById(Integer.valueOf(answerId.get(i)));
                   answer.setAnswerValue(answer.getAnswerValue()+1); //实现答案选择人数自增
                   answerDao.updateApplyValues(answer);   //修改答案点击数

        }
        Answer answer=answerDao.selectAnswerById(Integer.valueOf(answerId.get(0)));
        Question question=answer.getQuestion();
        Main main=question.getMain();
        main.setMainAnswer(main.getMainAnswer()+1);  //实现问卷回答人数自增
        mainDao.updateMainAnswer(main);        //修改问卷答题人数//自增一次即可
    }
    //保存答案
    @Transactional
    public boolean insertAnswer(String[] answerText,Integer quesId,Integer answerNum){
        Integer k=0;
        for(String answerDesType:answerText) {
            Answer answer = new Answer();
            Question question=new Question();
            question.setQuesId(quesId);              //保存答案所在的问题id
            answer.setAnswerDesType(answerDesType);  //保存答案文本信息
            answer.setAnswerCreateTime(new Date());
            answer.setAnswerType("n");
            answer.setAnswerText("/");
            answer.setQuestion(question);
            k=k+answerDao.insertAnswer(answer);

        }
        if(k==answerNum) {
            return true;
        }else{
            return  false;
        }

    }
    //通过quesId获取答案
    public List<Answer> selectAnswerByQuesId(Integer quesId){
        return answerDao.selectAnswerByQuesId(quesId);
    }
}
