package com.example.demo.service;

import com.example.demo.entity.Materials;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (Materials)表服务接口
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
public interface MaterialsService {

    /**
     * 通过ID查询单条数据
     *
     * @param materialsId 主键
     * @return 实例对象
     */
    Materials queryById(Integer materialsId);

    /**
     * 分页查询
     *
     * @param materials 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Materials> queryByPage(Materials materials, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param materials 实例对象
     * @return 实例对象
     */
    Materials insert(Materials materials);

    /**
     * 修改数据
     *
     * @param materials 实例对象
     * @return 实例对象
     */
    Materials update(Materials materials);

    /**
     * 通过主键删除数据
     *
     * @param materialsId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer materialsId);

}
