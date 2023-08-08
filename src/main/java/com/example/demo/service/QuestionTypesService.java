package com.example.demo.service;

import com.example.demo.entity.QuestionTypes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (QuestionTypes) table services interface
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
public interface QuestionTypesService {

    /**
     * query By id
     *
     * @param questionTypeId primary key
     * @return entity
     */
    QuestionTypes queryById(Integer questionTypeId);

    /**
     * query By limit
     *
     * @param questionTypes condition
     * @param pageRequest  page request
     * @return entity list
     */
    Page<QuestionTypes> queryByPage(QuestionTypes questionTypes, Pageable pageRequest);

    /**
     * add new data
     *
     * @param questionTypes entity
     * @return entity
     */
    QuestionTypes insert(QuestionTypes questionTypes);

    /**
     * update data
     *
     * @param questionTypes entity
     * @return entity
     */
    QuestionTypes update(QuestionTypes questionTypes);

    /**
     * delete By id
     *
     * @param questionTypeId primary key
     * @return boolean
     */
    boolean deleteById(Integer questionTypeId);

}
