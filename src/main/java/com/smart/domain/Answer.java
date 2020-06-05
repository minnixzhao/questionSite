package com.smart.domain;

import java.util.Date;

public class Answer {
    private Integer answerId;
    private Integer answerValue;   //回答次数
    private String answerType;     //有无附件
    private String answerDesType;  //文字描述
    private String answerText;     //附件路径
    private Date answerCreateTime; //回答时间
    private Question question;     //答案对应的问题

    public Integer getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Integer answerId) {
        this.answerId = answerId;
    }

    public Integer getAnswerValue() {
        return answerValue;
    }

    public void setAnswerValue(Integer answerValue) {
        this.answerValue = answerValue;
    }

    public String getAnswerType() {
        return answerType;
    }

    public void setAnswerType(String answerType) {
        this.answerType = answerType;
    }

    public String getAnswerDesType() {
        return answerDesType;
    }

    public void setAnswerDesType(String answerDesType) {
        this.answerDesType = answerDesType;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public Date getAnswerCreateTime() {
        return answerCreateTime;
    }

    public void setAnswerCreateTime(Date answerCreateTime) {
        this.answerCreateTime = answerCreateTime;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public String toString() {
        return "Answer{" +
                "answerId=" + answerId +
                ", answerValue=" + answerValue +
                ", answerType='" + answerType + '\'' +
                ", answerDesType='" + answerDesType + '\'' +
                ", answerText='" + answerText + '\'' +
                ", answerCreateTime=" + answerCreateTime +
                ", question=" + question +
                '}';
    }
}
