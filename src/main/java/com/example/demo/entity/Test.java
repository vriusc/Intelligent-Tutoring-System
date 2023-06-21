package com.example.demo.entity;

import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;

/**
 * (Test)实体类
 *
 * @author makejava
 * @since 2023-06-21 15:21:27
 */
@Mapper
public class Test implements Serializable {
    private static final long serialVersionUID = -78882894393667671L;
    
    private Integer testId;
    
    private String title;


    public Integer getTestId() {
        return testId;
    }

    public void setTestId(Integer testId) {
        this.testId = testId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}

