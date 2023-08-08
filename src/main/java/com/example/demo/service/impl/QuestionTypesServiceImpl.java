package com.example.demo.service.impl;

import com.example.demo.entity.QuestionTypes;
import com.example.demo.dao.QuestionTypesDao;
import com.example.demo.service.QuestionTypesService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;

import javax.annotation.Resource;

/**
 * (QuestionTypes) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
@Service("questionTypesService")
public class QuestionTypesServiceImpl implements QuestionTypesService {
    @Resource
    private QuestionTypesDao questionTypesDao;

    /**
     * query By id
     *
     * @param questionTypeId primary key
     * @return entity
     */
    @Override
    public QuestionTypes queryById(Integer questionTypeId) {
        return this.questionTypesDao.queryById(questionTypeId);
    }

    /**
     * query By limit
     *
     * @param questionTypes  query condition
     * @param pageRequest page request
     * @return entity list
     */
    @Override
    public Page<QuestionTypes> queryByPage(QuestionTypes questionTypes, Pageable pageRequest) {
        long total = this.questionTypesDao.count(questionTypes);
        return new PageImpl<>(this.questionTypesDao.queryAllByLimit(questionTypes, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param questionTypes entity
     * @return entity
     */
    @Override
    public QuestionTypes insert(QuestionTypes questionTypes) {
        this.questionTypesDao.insert(questionTypes);
        return questionTypes;
    }

    /**
     * update data
     *
     * @param questionTypes entity
     * @return entity
     */
    @Override
    public QuestionTypes update(QuestionTypes questionTypes) {
        this.questionTypesDao.update(questionTypes);
        return this.queryById(questionTypes.getQuestionTypeId());
    }

    /**
     * delete By id
     *
     * @param questionTypeId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer questionTypeId) {
        return this.questionTypesDao.deleteById(questionTypeId) > 0;
    }
}
