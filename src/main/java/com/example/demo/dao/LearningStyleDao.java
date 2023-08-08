package com.example.demo.dao;

import com.example.demo.entity.LearningStyle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (LearningStyle) table dao
 *
 * @author qianyongru
 * @since 2023-07-08 04:19:23
 */
@Mapper
public interface LearningStyleDao {

    /**
     * query by id
     *
     * @param learningStyleId primary key
     * @return object
     */
    LearningStyle queryById(Integer learningStyleId);

    /**
     * query all by limit
     *
     * @param learningStyle condition
     * @param pageable pageable
     * @return List<LearningStyle>
     */
    List<LearningStyle> queryAllByLimit(@Param("learningStyle") LearningStyle learningStyle, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param learningStyle condition
     * @return long
     */
    long count(LearningStyle learningStyle);

    /**
     * add data
     *
     * @param learningStyle entity
     * @return rows
     */
    int insert(LearningStyle learningStyle);

    /**
     * add batch
     *
     * @param entities List<LearningStyle> entities
     * @return rows
     */
    int insertBatch(@Param("entities") List<LearningStyle> entities);

    /**
     * add or update batch
     *
     * @param entities List<LearningStyle> entities
     * @return rows
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<LearningStyle> entities);

    /**
     * update data
     *
     * @param learningStyle entity
     * @return rows
     */
    int update(LearningStyle learningStyle);

    /**
     * delete by id
     *
     * @param learningStyleId primary key
     * @return rows
     */
    int deleteById(Integer learningStyleId);

}

