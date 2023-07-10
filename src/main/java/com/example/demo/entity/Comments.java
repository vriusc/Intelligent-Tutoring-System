package com.example.demo.entity;

import lombok.Data;

import java.util.Date;
import java.io.Serializable;

/**
 * (Comments)实体类
 *
 * @author makejava
 * @since 2023-07-08 05:07:47
 */
@Data
public class Comments implements Serializable {
    private static final long serialVersionUID = -53793725904282836L;
    
    private Integer commentId;
    
    private Integer studentId;
    
    private Integer questionId;
    
    private String comment;
    
    private Date time;
    
    private Integer likes;

}

