package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (QuestionTypes) entity
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
@Data
public class QuestionTypes implements Serializable {
    private static final long serialVersionUID = 899814981166863726L;
    
    private Integer questionTypeId;
    
    private String questionType;

}

