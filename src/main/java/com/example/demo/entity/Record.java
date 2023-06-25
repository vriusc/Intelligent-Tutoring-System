package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Record)实体类
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
@Data
public class Record implements Serializable {
    private static final long serialVersionUID = -28279513082094579L;
    
    private Integer recordId;
    
    private Integer studentId;
    
    private Integer questionId;
    
    private Integer optionId;

    private StudentUser studentUser;

    private Questions questions;

    private Options options;
}

