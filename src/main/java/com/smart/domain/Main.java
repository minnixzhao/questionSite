package com.smart.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class Main {
    private Integer mainId;
    private String mainTitle;
    private Date  mainCreateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date  mainEndTime;
    private String mainIsuse;
    private String mainCreateUser;
    private Integer mainAnswer;  //回答人数
    private List<Question> questionList;

    public Integer getMainId() {
        return mainId;
    }

    public void setMainId(Integer mainId) {
        this.mainId = mainId;
    }

    public String getMainIsuse() {
        return mainIsuse;
    }

    public void setMainIsuse(String mainIsuse) {
        this.mainIsuse = mainIsuse;
    }

    public String getMainTitle() {
        return mainTitle;
    }

    public void setMainTitle(String mainTitle) {
        this.mainTitle = mainTitle;
    }

    public Date getMainCreateTime() {
        return mainCreateTime;
    }

    public void setMainCreateTime(Date mainCreateTime) {
        this.mainCreateTime = mainCreateTime;
    }

    public Date getMainEndTime() {
        return mainEndTime;
    }

    public void setMainEndTime(Date mainEndTime) {
        this.mainEndTime = mainEndTime;
    }

    public String getMainCreateUser() {
        return mainCreateUser;
    }

    public void setMainCreateUser(String mainCreateUser) {
        this.mainCreateUser = mainCreateUser;
    }

    public Integer getMainAnswer() {
        return mainAnswer;
    }

    public void setMainAnswer(Integer mainAnswer) {
        this.mainAnswer = mainAnswer;
    }


    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }


    @Override
    public String toString() {
        return "Main{" +
                "mainId=" + mainId +
                ", mainTitle='" + mainTitle + '\'' +
                ", mainCreateTime=" + mainCreateTime +
                ", mainEndTime=" + mainEndTime +
                ", mainIsuse='" + mainIsuse + '\'' +
                ", mainCreateUser='" + mainCreateUser + '\'' +
                ", mainAnswer=" + mainAnswer +
                ", questionList=" + questionList +
                '}';
    }
}
