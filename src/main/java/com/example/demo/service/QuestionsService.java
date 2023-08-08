package com.example.demo.service;

import com.example.demo.entity.Questions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Questions) table services interface
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
public interface QuestionsService {

    /**
     * query By id
     *
     * @param questionId primary key
     * @return entity
     */
    Questions queryById(Integer questionId);

    /**
     * query By limit
     *
     * @param questions condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<Questions> queryByPage(Questions questions, Pageable pageRequest);

    /**
     * add new data
     *
     * @param questions entity
     * @return entity
     */
    Questions insert(Questions questions);

    /**
     * update data
     *
     * @param questions entity
     * @return entity
     */
    Questions update(Questions questions);

    /**
     * delete By id
     *
     * @param questionId primary key
     * @return boolean
     */
    boolean deleteById(Integer questionId);

}
