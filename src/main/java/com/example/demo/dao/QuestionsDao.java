package com.example.demo.dao;

import com.example.demo.entity.Questions;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Questions) table dao
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
@Mapper
public interface QuestionsDao {

    /**
     * query by id
     *
     * @param questionId primary key
     * @return object
     */
    Questions queryById(Integer questionId);

    /**
     * query all by limit
     *
     * @param questions condition
     * @param pageable pageable
     * @return List<Questions>
     */
    List<Questions> queryAllByLimit(@Param("Questions") Questions questions, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param questions condition
     * @return long
     */
    long count(Questions questions);

    /**
     * add data
     *
     * @param questions entity
     * @return row
     */
    int insert(Questions questions);

    /**
     * add batch
     *
     * @param entities List<Questions> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<Questions> entities);

    /**
     * add or update batch
     *
     * @param entities List<Questions> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<Questions> entities);

    /**
     * update data
     *
     * @param questions entity
     * @return row
     */
    int update(Questions questions);

    /**
     * delete by id
     *
     * @param questionId primary key
     * @return row
     */
    int deleteById(Integer questionId);

}

