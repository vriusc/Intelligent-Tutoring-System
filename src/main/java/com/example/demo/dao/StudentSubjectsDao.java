package com.example.demo.dao;

import com.example.demo.entity.StudentSubjects;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (StudentSubjects) table dao
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
@Mapper
public interface StudentSubjectsDao {

    /**
     * query by id
     *
     * @param studentSubjectId primary key
     * @return object
     */
    StudentSubjects queryById(Integer studentSubjectId);

    /**
     * query all by limit
     *
     * @param studentSubjects condition
     * @param pageable pageable
     * @return List<StudentSubjects>
     */
    List<StudentSubjects> queryAllByLimit(StudentSubjects studentSubjects, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param studentSubjects condition
     * @return long
     */
    long count(StudentSubjects studentSubjects);

    /**
     * add data
     *
     * @param studentSubjects entity
     * @return row
     */
    int insert(StudentSubjects studentSubjects);

    /**
     * add batch
     *
     * @param entities List<StudentSubjects> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<StudentSubjects> entities);

    /**
     * add or update batch
     *
     * @param entities List<StudentSubjects> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<StudentSubjects> entities);

    /**
     * update data
     *
     * @param studentSubjects entity
     * @return row
     */
    int update(StudentSubjects studentSubjects);

    /**
     * delete by id
     *
     * @param studentSubjectId primary key
     * @return row
     */
    int deleteById(Integer studentSubjectId);

    List<StudentSubjects> queryByStudentId(Integer studentId);


}

