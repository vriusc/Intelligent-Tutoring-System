package com.example.demo.service;

import com.example.demo.entity.Subjects;
import org.springframework.data.domain.Page;

import org.springframework.data.domain.Pageable;

/**
 * (Subjects)表服务接口
 *
 * @author makejava
 * @since 2023-06-22 06:24:38
 */
public interface SubjectsService {

    /**
     * 通过ID查询单条数据
     *
     * @param subjectId 主键
     * @return 实例对象
     */
    Subjects queryById(Integer subjectId);

    /**
     * 分页查询
     *
     * @param subjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Subjects> queryByPage(Subjects subjects, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param subjects 实例对象
     * @return 实例对象
     */
    Subjects insert(Subjects subjects);

    /**
     * 修改数据
     *
     * @param subjects 实例对象
     * @return 实例对象
     */
    Subjects update(Subjects subjects);

    /**
     * 通过主键删除数据
     *
     * @param subjectId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer subjectId);

}
