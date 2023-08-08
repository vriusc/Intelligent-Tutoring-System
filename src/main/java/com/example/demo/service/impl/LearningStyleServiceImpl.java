package com.example.demo.service.impl;

import com.example.demo.entity.LearningStyle;
import com.example.demo.dao.LearningStyleDao;
import com.example.demo.service.LearningStyleService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (LearningStyle) table services implement class
 *
 * @author qianyongru
 * @since 2023-07-08 04:19:23
 */
@Service("learningStyleService")
public class LearningStyleServiceImpl implements LearningStyleService {
    @Resource
    private LearningStyleDao learningStyleDao;

    /**
     * query By id
     *
     * @param learningStyleId primary key
     * @return entity
     */
    @Override
    public LearningStyle queryById(Integer learningStyleId) {
        return this.learningStyleDao.queryById(learningStyleId);
    }

    /**
     * query By limit
     *
     * @param learningStyle  query condition
     * @param pageRequest    page request
     * @return entity list
     */
    @Override
    public Page<LearningStyle> queryByPage(LearningStyle learningStyle, Pageable pageRequest) {
        long total = this.learningStyleDao.count(learningStyle);
        return new PageImpl<>(this.learningStyleDao.queryAllByLimit(learningStyle, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param learningStyle entity
     * @return entity
     */
    @Override
    public LearningStyle insert(LearningStyle learningStyle) {
        this.learningStyleDao.insert(learningStyle);
        return learningStyle;
    }

    /**
     * update data
     *
     * @param learningStyle entity
     * @return entity
     */
    @Override
    public LearningStyle update(LearningStyle learningStyle) {
        this.learningStyleDao.update(learningStyle);
        return this.queryById(learningStyle.getLearningStyleId());
    }

    /**
     * delete By id
     *
     * @param learningStyleId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer learningStyleId) {
        return this.learningStyleDao.deleteById(learningStyleId) > 0;
    }
}
