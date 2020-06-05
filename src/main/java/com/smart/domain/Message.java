package com.smart.domain;

import java.util.Date;

public class Message {
    private Integer messageId;
    private String messageText;
    private String messageCreater;
    private Date   messageCreateTime;
    private Main main;

    public Integer getMessageId() {
        return messageId;
    }

    public void setMessageId(Integer messageId) {
        this.messageId = messageId;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public String getMessageCreater() {
        return messageCreater;
    }

    public void setMessageCreater(String messageCreater) {
        this.messageCreater = messageCreater;
    }

    public Date getMessageCreateTime() {
        return messageCreateTime;
    }

    public void setMessageCreateTime(Date messageCreateTime) {
        this.messageCreateTime = messageCreateTime;
    }

    public Main getMain() {
        return main;
    }

    public void setMain(Main main) {
        this.main = main;
    }

    @Override
    public String toString() {
        return "Message{" +
                "messageId=" + messageId +
                ", messageText='" + messageText + '\'' +
                ", messageCreater='" + messageCreater + '\'' +
                ", messageCreateTime=" + messageCreateTime +
                ", main=" + main +
                '}';
    }
}
