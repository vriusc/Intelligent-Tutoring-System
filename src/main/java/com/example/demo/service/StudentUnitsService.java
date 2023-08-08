package com.example.demo.service;

import com.example.demo.entity.StudentUnits;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (StudentUnits) table services interface
 *
 * @author qianyongru
 * @since 2023-07-17 11:52:24
 */
public interface StudentUnitsService {

    /**
     * query By id
     *
     * @param studentUnitId primary key
     * @return entity
     */
    StudentUnits queryById(Integer studentUnitId);

    /**
     * query By limit
     *
     * @param studentUnits   query condition
     * @param pageRequest  page request
     * @return entity list
     */
    Page<StudentUnits> queryByPage(StudentUnits studentUnits, Pageable pageRequest);

    /**
     * add new data
     *
     * @param studentUnits entity
     * @return entity
     */
    StudentUnits insert(StudentUnits studentUnits);

    /**
     * update data
     *
     * @param studentUnits entity
     * @return entity
     */
    StudentUnits update(StudentUnits studentUnits);

    /**
     * delete By id
     *
     * @param studentUnitId primary key
     * @return  boolean
     */
    boolean deleteById(Integer studentUnitId);

}
