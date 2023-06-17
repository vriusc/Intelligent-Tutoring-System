package com.example.IntelligentTutorSystem.pojo;

public class Msg<T> {
    private T data;
    private Integer code;
    private String msg;


    public Msg(Integer code, String msg) {
        this(code, msg, null);
    }
    public Msg(Integer code, String msg, T data) {
        this.data = data;
        this.msg = msg;
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}