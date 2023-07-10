package com.example.demo.service.impl;

import com.example.demo.entity.LearningStyle;
import com.example.demo.dao.LearningStyleDao;
import com.example.demo.service.LearningStyleService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (LearningStyle)表服务实现类
 *
 * @author makejava
 * @since 2023-07-08 04:19:23
 */
@Service("learningStyleService")
public class LearningStyleServiceImpl implements LearningStyleService {
    @Resource
    private LearningStyleDao learningStyleDao;

    /**
     * 通过ID查询单条数据
     *
     * @param learningStyleId 主键
     * @return 实例对象
     */
    @Override
    public LearningStyle queryById(Integer learningStyleId) {
        return this.learningStyleDao.queryById(learningStyleId);
    }

    /**
     * 分页查询
     *
     * @param learningStyle 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<LearningStyle> queryByPage(LearningStyle learningStyle, Pageable pageRequest) {
        long total = this.learningStyleDao.count(learningStyle);
        return new PageImpl<>(this.learningStyleDao.queryAllByLimit(learningStyle, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param learningStyle 实例对象
     * @return 实例对象
     */
    @Override
    public LearningStyle insert(LearningStyle learningStyle) {
        this.learningStyleDao.insert(learningStyle);
        return learningStyle;
    }

    /**
     * 修改数据
     *
     * @param learningStyle 实例对象
     * @return 实例对象
     */
    @Override
    public LearningStyle update(LearningStyle learningStyle) {
        this.learningStyleDao.update(learningStyle);
        return this.queryById(learningStyle.getLearningStyleId());
    }

    /**
     * 通过主键删除数据
     *
     * @param learningStyleId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer learningStyleId) {
        return this.learningStyleDao.deleteById(learningStyleId) > 0;
    }
}
