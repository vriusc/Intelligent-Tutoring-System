package com.example.demo.service;

import com.example.demo.entity.LearningStyle;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (LearningStyle)表服务接口
 *
 * @author makejava
 * @since 2023-07-08 04:19:23
 */
public interface LearningStyleService {

    /**
     * 通过ID查询单条数据
     *
     * @param learningStyleId 主键
     * @return 实例对象
     */
    LearningStyle queryById(Integer learningStyleId);

    /**
     * 分页查询
     *
     * @param learningStyle 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<LearningStyle> queryByPage(LearningStyle learningStyle, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param learningStyle 实例对象
     * @return 实例对象
     */
    LearningStyle insert(LearningStyle learningStyle);

    /**
     * 修改数据
     *
     * @param learningStyle 实例对象
     * @return 实例对象
     */
    LearningStyle update(LearningStyle learningStyle);

    /**
     * 通过主键删除数据
     *
     * @param learningStyleId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer learningStyleId);

}
