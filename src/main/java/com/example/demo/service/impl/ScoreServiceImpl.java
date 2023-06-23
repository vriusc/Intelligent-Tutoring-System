package com.example.demo.service.impl;

import com.example.demo.entity.Score;
import com.example.demo.dao.ScoreDao;
import com.example.demo.service.ScoreService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (Score)表服务实现类
 *
 * @author makejava
 * @since 2023-06-23 16:05:58
 */
@Service("scoreService")
public class ScoreServiceImpl implements ScoreService {
    @Resource
    private ScoreDao scoreDao;

    /**
     * 通过ID查询单条数据
     *
     * @param scoreId 主键
     * @return 实例对象
     */
    @Override
    public Score queryById(Integer scoreId) {
        return this.scoreDao.queryById(scoreId);
    }

    /**
     * 分页查询
     *
     * @param score 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Score> queryByPage(Score score, PageRequest pageRequest) {
        long total = this.scoreDao.count(score);
        return new PageImpl<>(this.scoreDao.queryAllByLimit(score, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param score 实例对象
     * @return 实例对象
     */
    @Override
    public Score insert(Score score) {
        this.scoreDao.insert(score);
        return score;
    }

    /**
     * 修改数据
     *
     * @param score 实例对象
     * @return 实例对象
     */
    @Override
    public Score update(Score score) {
        this.scoreDao.update(score);
        return this.queryById(score.getScoreId());
    }

    /**
     * 通过主键删除数据
     *
     * @param scoreId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer scoreId) {
        return this.scoreDao.deleteById(scoreId) > 0;
    }
}
