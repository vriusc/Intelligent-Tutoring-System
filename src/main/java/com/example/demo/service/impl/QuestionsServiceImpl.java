package com.example.demo.service.impl;

import com.example.demo.entity.Questions;
import com.example.demo.dao.QuestionsDao;
import com.example.demo.service.QuestionsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (Questions) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
@Service("questionsService")
public class QuestionsServiceImpl implements QuestionsService {
    @Resource
    private QuestionsDao questionsDao;

    /**
     * query By id
     *
     * @param questionId primary key
     * @return entity
     */
    @Override
    public Questions queryById(Integer questionId) {
        return this.questionsDao.queryById(questionId);
    }

    /**
     * query By limit
     *
     * @param questions query condition
     * @param pageRequest page request
     * @return entity list
     */
    @Override
    public Page<Questions> queryByPage(Questions questions, Pageable pageRequest) {
        long total = this.questionsDao.count(questions);
        return new PageImpl<>(this.questionsDao.queryAllByLimit(questions, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param questions entity
     * @return entity
     */
    @Override
    public Questions insert(Questions questions) {
        this.questionsDao.insert(questions);
        return questions;
    }

    /**
     * update data
     *
     * @param questions entity
     * @return entity
     */
    @Override
    public Questions update(Questions questions) {
        this.questionsDao.update(questions);
        return this.queryById(questions.getQuestionId());
    }

    /**
     * delete By id
     *
     * @param questionId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer questionId) {
        return this.questionsDao.deleteById(questionId) > 0;
    }
}
