package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Options) entity
 *
 * @author makejava
 * @since 2023-06-23 10:58:28
 */

@Data
public class Options implements Serializable {
    private static final long serialVersionUID = 402090795382669059L;
    
    private Integer optionId;
    
    private Integer questionId;
    
    private String option;
    
    private Integer isCorrect;
    
    private Integer orderNumber;

    private String description;

    private Questions questions;

}

