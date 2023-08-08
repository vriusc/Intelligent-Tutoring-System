package com.example.demo.dao;

import com.example.demo.entity.Options;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Options) table dao
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
@Mapper
public interface OptionsDao {

    /**
     * query by id
     *
     * @param optionId primary key
     * @return object
     */
    Options queryById(Integer optionId);

    /**
     * query all by limit
     *
     * @param options condition
     * @param pageable pageable
     * @return List<Options>
     */
    List<Options> queryAllByLimit(@Param("options") Options options, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param options condition
     * @return row
     */
    long count(Options options);

    /**
     * add data
     *
     * @param options entity
     * @return row
     */
    int insert(Options options);

    /**
     * add batch
     *
     * @param entities List<Options> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<Options> entities);

    /**
     * add or update batch
     *
     * @param entities List<Options> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<Options> entities);

    /**
     * update data
     *
     * @param options entity
     * @return row
     */
    int update(Options options);

    /**
     * delete by id
     *
     * @param optionId primary key
     * @return row
     */
    int deleteById(Integer optionId);

}

