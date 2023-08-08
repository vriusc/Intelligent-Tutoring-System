package com.example.demo.dao;

import com.example.demo.entity.QuestionUnits;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (QuestionUnits) table dao
 *
 * @author qianyongru
 * @since 2023-06-23 09:31:50
 */
@Mapper
public interface QuestionUnitsDao {

    /**
     * query by id
     *
     * @param questionUnitId primary key
     * @return object
     */
    QuestionUnits queryById(Integer questionUnitId);

    /**
     * query all by limit
     *
     * @param questionUnits condition
     * @param pageable pageable
     * @return List<QuestionUnits>
     */
    List<QuestionUnits> queryAllByLimit(@Param("questionUnits") QuestionUnits questionUnits, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param questionUnits condition
     * @return long
     */
    long count(QuestionUnits questionUnits);

    /**
     * add data
     *
     * @param questionUnits entity
     * @return row
     */
    int insert(QuestionUnits questionUnits);

    /**
     * add batch
     *
     * @param entities List<QuestionUnits> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<QuestionUnits> entities);

    /**
     * add or update batch
     *
     * @param entities List<QuestionUnits> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<QuestionUnits> entities);

    /**
     * update data
     *
     * @param questionUnits entity
     * @return row
     */
    int update(QuestionUnits questionUnits);

    /**
     * delete by id
     *
     * @param questionUnitId primary key
     * @return row
     */
    int deleteById(Integer questionUnitId);

}

