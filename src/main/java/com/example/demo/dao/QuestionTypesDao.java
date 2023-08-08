package com.example.demo.dao;

import com.example.demo.entity.QuestionTypes;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (QuestionTypes) table dao
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
@Mapper
public interface QuestionTypesDao {

    /**
     * query by id
     *
     * @param questionTypeId primary key
     * @return entity
     */
    QuestionTypes queryById(Integer questionTypeId);

    /**
     * query all by limit
     *
     * @param questionTypes condition
     * @param pageable pageable
     * @return List<QuestionTypes>
     */
    List<QuestionTypes> queryAllByLimit(@Param("questionTypes") QuestionTypes questionTypes, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param questionTypes condition
     * @return long
     */
    long count(QuestionTypes questionTypes);

    /**
     * add data
     *
     * @param questionTypes entity
     * @return row
     */
    int insert(QuestionTypes questionTypes);

    /**
     * add batch
     *
     * @param entities List<QuestionTypes> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<QuestionTypes> entities);

    /**
     * add or update batch
     *
     * @param entities List<QuestionTypes> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<QuestionTypes> entities);

    /**
     * update data
     *
     * @param questionTypes entity
     * @return row
     */
    int update(QuestionTypes questionTypes);

    /**
     * delete by id
     *
     * @param questionTypeId primary key
     * @return row
     */
    int deleteById(Integer questionTypeId);

}

