package com.smart.domain;

import java.util.Date;
import java.util.List;

public class Question {
    private Integer quesId;
    private String quesTitle;
    private Date quesCreateTime;
    private String quesType;   //问题类型
    private  List<Answer> answerList;
    private Main main;
    public Integer getQuesId() {
        return quesId;
    }

    public void setQuesId(Integer quesId) {
        this.quesId = quesId;
    }

    public String getQuesTitle() {
        return quesTitle;
    }

    public void setQuesTitle(String quesTitle) {
        this.quesTitle = quesTitle;
    }

    public Date getQuesCreateTime() {
        return quesCreateTime;
    }

    public void setQuesCreateTime(Date quesCreateTime) {
        this.quesCreateTime = quesCreateTime;
    }

    public String getQuesType() {
        return quesType;
    }

    public void setQuesType(String quesType) {
        this.quesType = quesType;
    }

    public List<Answer> getAnswerList() {
        return answerList;
    }

    public void setAnswerList(List<Answer> answerList) {
        this.answerList = answerList;
    }

    public Main getMain() {
        return main;
    }

    public void setMain(Main main) {
        this.main = main;
    }

    @Override
    public String toString() {
        return "Question{" +
                "quesId=" + quesId +
                ", quesTitle='" + quesTitle + '\'' +
                ", quesCreateTime=" + quesCreateTime +
                ", quesType='" + quesType + '\'' +
                ", answerList=" + answerList +
                ", main=" + main +
                '}';
    }
}
