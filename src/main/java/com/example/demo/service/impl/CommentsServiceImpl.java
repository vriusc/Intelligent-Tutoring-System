package com.example.demo.service.impl;

import com.example.demo.entity.Comments;
import com.example.demo.dao.CommentsDao;
import com.example.demo.service.CommentsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import javax.annotation.Resource;

/**
 * (Comments) table services implement class
 *
 * @author qianyongru
 * @since 2023-07-08 05:07:47
 */
@Service("commentsService")
public class CommentsServiceImpl implements CommentsService {
    @Resource
    private CommentsDao commentsDao;

    /**
     * query By id
     *
     * @param commentId primary key
     * @return entity
     */
    @Override
    public Comments queryById(Integer commentId) {
        return this.commentsDao.queryById(commentId);
    }

    /**
     * query By limit
     *
     * @param comments query condition
     * @param pageRequest page request
     * @return entity list
     */
    @Override
    public Page<Comments> queryByPage(Comments comments, Pageable pageRequest) {
        long total = this.commentsDao.count(comments);
        return new PageImpl<>(this.commentsDao.queryAllByLimit(comments, pageRequest), pageRequest, total);
    }


    /**
     * add new data
     *
     * @param comments entity
     * @return entity
     */
    @Override
    public Comments insert(Comments comments) {
        comments.setTime(new java.sql.Timestamp(System.currentTimeMillis()));
        this.commentsDao.insert(comments);
        return comments;
    }

    /**
     * update data
     *
     * @param comments entity
     * @return entity
     */
    @Override
    public Comments update(Comments comments) {
        this.commentsDao.update(comments);
        return this.queryById(comments.getCommentId());
    }

    /**
     * delete By id
     *
     * @param commentId primary key
     * @return success or not
     */
    @Override
    public boolean deleteById(Integer commentId) {
        return this.commentsDao.deleteById(commentId) > 0;
    }
}
