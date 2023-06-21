package com.example.demo.entity;

import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;

/**
 * (TestListeningJudgementByPicture)实体类
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
@Mapper
public class TestListeningJudgementByPicture implements Serializable {
    private static final long serialVersionUID = 841312388095691608L;
    
    private Integer testListeningJudgementByPictureId;
    
    private Integer testId;
    
    private Integer listeningJudgementByPictureId;

    private Test test;

    private ListeningJudgementByPicture listeningJudgementByPicture;

    public TestListeningJudgementByPicture() {
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    public ListeningJudgementByPicture getListeningJudgementByPicture() {
        return listeningJudgementByPicture;
    }

    public void setListeningJudgementByPicture(ListeningJudgementByPicture listeningJudgementByPicture) {
        this.listeningJudgementByPicture = listeningJudgementByPicture;
    }

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

