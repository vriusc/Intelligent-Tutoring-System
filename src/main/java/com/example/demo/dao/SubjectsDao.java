package com.example.demo.dao;

import com.example.demo.entity.Subjects;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Subjects) table dao
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
@Mapper
public interface SubjectsDao {

    /**
     * query by id
     *
     * @param subjectId primary key
     * @return object
     */
    Subjects queryById(Integer subjectId);

    /**
     * query all by limit
     *
     * @param subjects condition
     * @param pageable pageable
     * @return List<Subjects>
     */
    List<Subjects> queryAllByLimit(@Param("subjects") Subjects subjects, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param subjects condition
     * @return long
     */
    long count(Subjects subjects);

    /**
     * add data
     *
     * @param subjects entity
     * @return row
     */
    int insert(Subjects subjects);

    /**
     * add batch
     *
     * @param entities List<Subjects> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<Subjects> entities);

    /**
     * add or update batch
     *
     * @param entities List<Subjects> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<Subjects> entities);

    /**
     * update data
     *
     * @param subjects entity
     * @return row
     */
    int update(Subjects subjects);

    /**
     * delete by id
     *
     * @param subjectId primary key
     * @return row
     */
    int deleteById(Integer subjectId);

}

