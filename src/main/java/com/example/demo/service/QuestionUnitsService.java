package com.example.demo.service;

import com.example.demo.entity.QuestionUnits;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (QuestionUnits) table services interface
 *
 * @author qianyongru
 * @since 2023-06-23 09:31:50
 */
public interface QuestionUnitsService {

    /**
     * query By id
     *
     * @param questionUnitId primary key
     * @return entity
     */
    QuestionUnits queryById(Integer questionUnitId);

    /**
     * query By limit
     *
     * @param questionUnits  condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<QuestionUnits> queryByPage(QuestionUnits questionUnits, Pageable pageRequest);

    /**
     * add new data
     *
     * @param questionUnits entity
     * @return entity
     */
    QuestionUnits insert(QuestionUnits questionUnits);

    /**
     * update data
     *
     * @param questionUnits entity
     * @return entity
     */
    QuestionUnits update(QuestionUnits questionUnits);

    /**
     * delete By id
     *
     * @param questionUnitId primary key
     * @return boolean
     */
    boolean deleteById(Integer questionUnitId);

}
