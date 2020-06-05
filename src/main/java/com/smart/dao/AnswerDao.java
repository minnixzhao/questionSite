package com.smart.dao;

import com.smart.domain.Answer;

import java.util.List;

public interface  AnswerDao {
    //通过answerId查询答案
    Answer selectAnswerById(Integer answerId);
    //修改答案点击次数
    void updateApplyValues(Answer answer);
    //保存答案
    Integer insertAnswer(Answer answer);
    //通过quesId获取答案
    List<Answer> selectAnswerByQuesId(Integer quesId);
    //更新答案
    Integer updateAnswerById(Answer answer);
    //删除答案
    Integer deleteAnswer(Integer quesId);
}
