package com.example.demo.service;

import com.example.demo.entity.Comments;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Comments) table services interface
 *
 * @author qianyongru
 * @since 2023-07-08 05:07:47
 */
public interface CommentsService {

    /**
     * query By id
     *
     * @param commentId primary key
     * @return entity
     */
    Comments queryById(Integer commentId);

    /**
     * query By limit
     *
     * @param comments query condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<Comments> queryByPage(Comments comments, Pageable pageRequest);

    /**
     * add new data
     *
     * @param comments entity
     * @return entity
     */
    Comments insert(Comments comments);

    /**
     * update data
     *
     * @param comments entity
     * @return entity
     */
    Comments update(Comments comments);

    /**
     * delete By id
     *
     * @param commentId primary key
     * @return boolean
     */
    boolean deleteById(Integer commentId);

}
