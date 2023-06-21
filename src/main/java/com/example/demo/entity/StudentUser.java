package com.example.demo.entity;

import java.io.Serializable;

/**
 * (StudentUser)实体类
 *
 * @author makejava
 * @since 2023-06-21 06:36:40
 */
public class StudentUser implements Serializable {
    private static final long serialVersionUID = -56269051532249524L;
    
    private Integer id;
    
    private String username;
    
    private String password;
    
    private String email;
    
    private String level;
    
    private Integer studyTime;


    public StudentUser() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Integer getStudyTime() {
        return studyTime;
    }

    public void setStudyTime(Integer studyTime) {
        this.studyTime = studyTime;
    }


}

