package com.example.demo.entity;

import lombok.Data;
import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;

/**
 * (TestListeningJudgementByPicture)实体类
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
@Data
@Mapper
public class TestListeningJudgementByPicture implements Serializable {
    private static final long serialVersionUID = 841312388095691608L;
    
    private Integer testListeningJudgementByPictureId;
    
    private Integer testId;
    
    private Integer listeningJudgementByPictureId;

    private Test test;

//
}

