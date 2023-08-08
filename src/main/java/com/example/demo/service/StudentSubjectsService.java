package com.example.demo.service;

import com.example.demo.entity.StudentSubjects;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

/**
 * (StudentSubjects) table services interface
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
public interface StudentSubjectsService {

    /**
     * query By id
     *
     * @param studentSubjectId primary key
     * @return entity
     */
    StudentSubjects queryById(Integer studentSubjectId);

    /**
     * query By limit
     *
     * @param studentSubjects condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<StudentSubjects> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest);


    /**
     * add new data
     *
     * @param studentSubjects entity
     * @return entity
     */
    StudentSubjects insert(StudentSubjects studentSubjects);

    /**
     * update data
     *
     * @param studentSubjects entity
     * @return entity
     */
    StudentSubjects update(StudentSubjects studentSubjects);

    /**
     * delete By id
     *
     * @param studentSubjectId primary key
     * @return boolean
     */
    boolean deleteById(Integer studentSubjectId);


    /**
     * query By studentId
     *
     * @param studentId primary key
     * @return entity list
     */

    List<StudentSubjects> queryByStudentId(Integer studentId);


}
