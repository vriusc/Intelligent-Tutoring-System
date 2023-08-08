package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (LearningStyle) entity
 *
 * @author makejava
 * @since 2023-07-08 04:19:23
 */
@Data
public class LearningStyle implements Serializable {
    private static final long serialVersionUID = 975067129543913047L;
    
    private Integer learningStyleId;
    
    private Integer studentId;
    
    private Integer activist;
    
    private Integer reflector;
    
    private Integer theorist;
    
    private Integer pragmatist;

}

