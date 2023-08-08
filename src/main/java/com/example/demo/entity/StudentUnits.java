package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (StudentUnits) entity
 *
 * @author makejava
 * @since 2023-07-17 11:52:24
 */
@Data
public class StudentUnits implements Serializable {
    private static final long serialVersionUID = -66652298912765131L;
    
    private Integer studentUnitId;
    
    private Integer studentId;
    
    private Integer unitId;
    
    private Integer isfinished;

}

