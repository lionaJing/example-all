package com.abc.bean;

/**
 * @author Shuai.Jing
 * @date 2019/3/27
 */
public class MessageDto {
    private String from;
    private String message;

    public MessageDto() {

    }

    public MessageDto(String from,String message) {
        this.from = from;
        this.message = message;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
