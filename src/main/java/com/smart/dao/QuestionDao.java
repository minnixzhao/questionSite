package com.smart.dao;

import com.smart.domain.Question;

public interface QuestionDao {
    //通过quesId获取问题
    Question selectQuestionById(Integer quesId);
    //通过quesId更改问题
    void updateQuestionById(Question question);
    //增加问题
    Integer addQuestion(Question question);
    //通过mainId删除问题及答案
    Integer deleteQuestion(Integer mainId);
    //通过quesId删除一个问题及答案
    Integer deleteQuestionById(Integer quesId);
}
