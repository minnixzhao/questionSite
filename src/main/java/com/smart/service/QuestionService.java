package com.smart.service;

import com.smart.dao.AnswerDao;
import com.smart.dao.QuestionDao;
import com.smart.domain.Answer;
import com.smart.domain.Main;
import com.smart.domain.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

@Service
public class QuestionService {
    @Autowired
    private QuestionDao questionDao;
    @Autowired
    private AnswerDao answerDao;
    //通过quesId获取问题
    public Question selectQuestionById(Integer quesId){
        return questionDao.selectQuestionById(quesId);
    }
    //通过quesId修改问题及答案
    @Transactional
    public void updateQuestionById(Map<String,String[]> map){
          Question question=new Question();
          question.setQuesType(map.get("questionType")[0]); //保存问题类型
          question.setQuesTitle(map.get("questionTitle")[0]); //保存问题标题
          question.setQuesId(Integer.valueOf(map.get("questionId")[0]));  //保存问题Id
          questionDao.updateQuestionById(question);  //修改问题

        //移除便于修改答案
        map.remove("mainId");
        map.remove("questionTitle");
        map.remove("questionType");
        map.remove("questionId");
        Set<Map.Entry<String,String[]>> entryset=map.entrySet();  //获取map中键值对的set集合
        for(Map.Entry<String,String[]> entry:entryset){
            Answer answer=new Answer();
            if(isNumeric(entry.getKey())) {                                   //判断答案Id是否为数字字符串
                answer.setAnswerId(Integer.valueOf(entry.getKey()));           //保存答案Id
            }
            answer.setAnswerDesType(entry.getValue()[0]);                     //保存答案
            Integer k= answerDao.updateAnswerById(answer);                   //修改答案

            //新增答案入数据库
            if(k!=1){
                answer.setAnswerCreateTime(new Date());
                answer.setAnswerText("/");
                answer.setAnswerType("n");
                answer.setQuestion(question);
                answerDao.insertAnswer(answer);
            }
        }

    }
    //判断是否为数字字符串
    public static boolean isNumeric(String str){
        Pattern pattern = Pattern.compile("[0-9]*");
        return pattern.matcher(str).matches();
    }
    //增加问题以及答案
    @Transactional
    public void addQuestionAndAnswer(Map<String,String[]> map){

        Question question=new Question();
        Main main=new  Main();
        main.setMainId(Integer.valueOf(map.get("mainId")[0]));
        question.setQuesTitle(map.get("questionTitle")[0]);
        question.setQuesType(map.get("questionType")[0]);
        question.setMain(main);
        question.setQuesCreateTime(new Date());
        questionDao.addQuestion(question); //增加问题
        //移除便于保存答案
        map.remove("mainId");
        map.remove("questionTitle");
        map.remove("questionType");
        Set<Map.Entry<String,String[]>> entrySet=map.entrySet();
        for(Map.Entry<String,String[]> entry:entrySet ){
            Answer answer=new Answer();
            answer.setAnswerCreateTime(new Date());
            answer.setAnswerDesType(entry.getValue()[0]);
            answer.setAnswerText("/");
            answer.setAnswerType("n");
            answer.setQuestion(question);
            answerDao.insertAnswer(answer);  //保存答案
        }
    }
    //删除一个问题及答案
    @Transactional
    public boolean deleteQuestionById(Integer quesId){
       Integer k= questionDao.deleteQuestionById(quesId);
       Integer n= answerDao.deleteAnswer(quesId);
       if(k!=0&&n!=0){return  true;}
       else {return  false;}
    }
}
