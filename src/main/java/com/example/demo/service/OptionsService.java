package com.example.demo.service;

import com.example.demo.entity.Options;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Options)表服务接口
 *
 * @author makejava
 * @since 2023-06-23 10:58:28
 */
public interface OptionsService {

    /**
     * 通过ID查询单条数据
     *
     * @param optionId 主键
     * @return 实例对象
     */
    Options queryById(Integer optionId);

    /**
     * 分页查询
     *
     * @param options 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Options> queryByPage(Options options, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param options 实例对象
     * @return 实例对象
     */
    Options insert(Options options);

    /**
     * 修改数据
     *
     * @param options 实例对象
     * @return 实例对象
     */
    Options update(Options options);

    /**
     * 通过主键删除数据
     *
     * @param optionId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer optionId);

}
