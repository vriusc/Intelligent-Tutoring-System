package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (QuestionUnits)实体类
 *
 * @author qianyongru
 * @since 2023-06-23 09:31:50
 */
@Data
public class QuestionUnits implements Serializable {
    private static final long serialVersionUID = -45240597876739213L;
    
    private Integer questionUnitId;
    
    private Integer questionId;
    
    private Integer unitId;

    private Questions questions;

    private Units units;

}

