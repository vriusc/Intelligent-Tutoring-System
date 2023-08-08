package com.example.demo.service.impl;

import com.example.demo.entity.QuestionUnits;
import com.example.demo.dao.QuestionUnitsDao;
import com.example.demo.service.QuestionUnitsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (QuestionUnits) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-23 09:31:50
 */
@Service("questionUnitsService")
public class QuestionUnitsServiceImpl implements QuestionUnitsService {
    @Resource
    private QuestionUnitsDao questionUnitsDao;

    /**
     * query By id
     *
     * @param questionUnitId primary key
     * @return entity
     */
    @Override
    public QuestionUnits queryById(Integer questionUnitId) {
        return this.questionUnitsDao.queryById(questionUnitId);
    }

    /**
     * query By limit
     *
     * @param questionUnits  query condition
     * @param pageRequest    page request
     * @return entity list
     */
    @Override
    public Page<QuestionUnits> queryByPage(QuestionUnits questionUnits, Pageable pageRequest) {
        long total = this.questionUnitsDao.count(questionUnits);
        return new PageImpl<>(this.questionUnitsDao.queryAllByLimit(questionUnits, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param questionUnits entity
     * @return entity
     */
    @Override
    public QuestionUnits insert(QuestionUnits questionUnits) {
        this.questionUnitsDao.insert(questionUnits);
        return questionUnits;
    }

    /**
     * update data
     *
     * @param questionUnits entity
     * @return entity
     */
    @Override
    public QuestionUnits update(QuestionUnits questionUnits) {
        this.questionUnitsDao.update(questionUnits);
        return this.queryById(questionUnits.getQuestionUnitId());
    }

    /**
     * delete By id
     *
     * @param questionUnitId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer questionUnitId) {
        return this.questionUnitsDao.deleteById(questionUnitId) > 0;
    }
}
