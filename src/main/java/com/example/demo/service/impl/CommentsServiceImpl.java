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
 * (Comments)表服务实现类
 *
 * @author makejava
 * @since 2023-07-08 05:07:47
 */
@Service("commentsService")
public class CommentsServiceImpl implements CommentsService {
    @Resource
    private CommentsDao commentsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param commentId 主键
     * @return 实例对象
     */
    @Override
    public Comments queryById(Integer commentId) {
        return this.commentsDao.queryById(commentId);
    }

    /**
     * 分页查询
     *
     * @param comments 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Comments> queryByPage(Comments comments, Pageable pageRequest) {
        long total = this.commentsDao.count(comments);
        return new PageImpl<>(this.commentsDao.queryAllByLimit(comments, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param comments 实例对象
     * @return 实例对象
     */
    @Override
    public Comments insert(Comments comments) {
        comments.setTime(new java.sql.Timestamp(System.currentTimeMillis()));
        this.commentsDao.insert(comments);
        return comments;
    }

    /**
     * 修改数据
     *
     * @param comments 实例对象
     * @return 实例对象
     */
    @Override
    public Comments update(Comments comments) {
        this.commentsDao.update(comments);
        return this.queryById(comments.getCommentId());
    }

    /**
     * 通过主键删除数据
     *
     * @param commentId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer commentId) {
        return this.commentsDao.deleteById(commentId) > 0;
    }
}
