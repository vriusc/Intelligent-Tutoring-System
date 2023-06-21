package com.example.demo.entity;

import java.io.Serializable;

/**
 * (TestListeningJudgementByPicture)实体类
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
public class TestListeningJudgementByPicture implements Serializable {
    private static final long serialVersionUID = 841312388095691608L;
    
    private Integer testListeningJudgementByPictureId;
    
    private Integer testId;
    
    private Integer listeningJudgementByPictureId;


    public Integer getTestListeningJudgementByPictureId() {
        return testListeningJudgementByPictureId;
    }

    public void setTestListeningJudgementByPictureId(Integer testListeningJudgementByPictureId) {
        this.testListeningJudgementByPictureId = testListeningJudgementByPictureId;
    }

    public Integer getTestId() {
        return testId;
    }

    public void setTestId(Integer testId) {
        this.testId = testId;
    }

    public Integer getListeningJudgementByPictureId() {
        return listeningJudgementByPictureId;
    }

    public void setListeningJudgementByPictureId(Integer listeningJudgementByPictureId) {
        this.listeningJudgementByPictureId = listeningJudgementByPictureId;
    }

}

