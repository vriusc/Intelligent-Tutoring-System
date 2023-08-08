package com.example.demo.dao;

import com.example.demo.entity.Comments;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Comments) table dao
 *
 * @author qianyongru
 * @since 2023-07-08 05:07:47
 */
@Mapper
public interface CommentsDao {

    /**
     * query by id
     *
     * @param commentId primary key
     * @return object
     */
    Comments queryById(Integer commentId);

    /**
     * query all by limit
     *
     * @param comments condition
     * @param pageable pageable
     * @return list<Comments>
     */
    List<Comments> queryAllByLimit(@Param("comments") Comments comments, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param comments condition
     * @return long
     */
    long count(Comments comments);

    /**
     * add data
     *
     * @param comments entity
     * @return int
     */
    int insert(Comments comments);

    /**
     * add batch
     *
     * @param entities List<Comments> entities
     * @return rows
     */
    int insertBatch(@Param("entities") List<Comments> entities);

    /**
     * add or update batch
     *
     * @param entities List<Comments> entities
     * @return rows
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<Comments> entities);

    /**
     * update data
     *
     * @param comments entity
     * @return rows
     */
    int update(Comments comments);

    /**
     * delete by id
     *
     * @param commentId primary key
     * @return rows
     */
    int deleteById(Integer commentId);

}

