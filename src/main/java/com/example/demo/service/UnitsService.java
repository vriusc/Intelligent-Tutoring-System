package com.example.demo.service;

import com.example.demo.entity.Units;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

/**
 * (Units) table services interface
 *
 * @author qianyongru
 * @since 2023-06-22 20:46:33
 */
public interface UnitsService {

    /**
     * query By id
     *
     * @param unitId primary key
     * @return entity
     */
    Units queryById(Integer unitId);

    /**
     * query By limit
     *
     * @param units condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<Units> queryByPage(Units units, PageRequest pageRequest);

    /**
     * add new data
     *
     * @param units entity
     * @return entity
     */
    Units insert(Units units);

    /**
     * update data
     *
     * @param units entity
     * @return entity
     */
    Units update(Units units);

    /**
     * delete By id
     *
     * @param unitId primary key
     * @return boolean
     */
    boolean deleteById(Integer unitId);

    /**
     * query By subject id
     *
     * @param subjectID primary key
     * @return entity list
     */
    List<Units> queryBySubjectId(Integer subjectID);


}
