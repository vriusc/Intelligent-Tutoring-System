package com.example.demo.service;

import com.example.demo.entity.Subjects;
import org.springframework.data.domain.Page;

import org.springframework.data.domain.Pageable;

/**
 * (Subjects) table services interface
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
public interface SubjectsService {

    /**
     * query By id
     *
     * @param subjectId primary key
     * @return entity
     */
    Subjects queryById(Integer subjectId);

    /**
     * query By limit
     *
     * @param subjects condition
     * @param pageRequest  page request
     * @return entity list
     */
    Page<Subjects> queryByPage(Subjects subjects, Pageable pageRequest);

    /**
     * add new data
     *
     * @param subjects entity
     * @return entity
     */
    Subjects insert(Subjects subjects);

    /**
     * update data
     *
     * @param subjects entity
     * @return entity
     */
    Subjects update(Subjects subjects);

    /**
     * delete By id
     *
     * @param subjectId primary key
     * @return boolean
     */
    boolean deleteById(Integer subjectId);

}
