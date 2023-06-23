package com.example.demo.service;

import com.example.demo.entity.Score;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (Score)表服务接口
 *
 * @author makejava
 * @since 2023-06-23 16:05:58
 */
public interface ScoreService {

    /**
     * 通过ID查询单条数据
     *
     * @param scoreId 主键
     * @return 实例对象
     */
    Score queryById(Integer scoreId);

    /**
     * 分页查询
     *
     * @param score 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Score> queryByPage(Score score, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param score 实例对象
     * @return 实例对象
     */
    Score insert(Score score);

    /**
     * 修改数据
     *
     * @param score 实例对象
     * @return 实例对象
     */
    Score update(Score score);

    /**
     * 通过主键删除数据
     *
     * @param scoreId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer scoreId);

}
