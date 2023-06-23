package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Score)实体类
 *
 * @author makejava
 * @since 2023-06-23 16:05:58
 */
@Data
public class Score implements Serializable {
    private static final long serialVersionUID = 360135279999670923L;
    
    private Integer scoreId;
    
    private Integer studentId;
    
    private Integer unitId;
    
    private Integer score;
}

