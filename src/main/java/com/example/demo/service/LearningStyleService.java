package com.example.demo.service;

import com.example.demo.entity.LearningStyle;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (LearningStyle) table services interface
 *
 * @author qianyongru
 * @since 2023-07-08 04:19:23
 */
public interface LearningStyleService {

    /**
     * query By id
     *
     * @param learningStyleId primary key
     * @return entity
     */
    LearningStyle queryById(Integer learningStyleId);

    /**
     * query By limit
     *
     * @param learningStyle  query condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<LearningStyle> queryByPage(LearningStyle learningStyle, Pageable pageRequest);

    /**
     * add new data
     *
     * @param learningStyle entity
     * @return entity
     */
    LearningStyle insert(LearningStyle learningStyle);

    /**
     * update data
     *
     * @param learningStyle entity
     * @return entity
     */
    LearningStyle update(LearningStyle learningStyle);

    /**
     * delete By id
     *
     * @param learningStyleId  primary key
     * @return boolean
     */
    boolean deleteById(Integer learningStyleId);

}
