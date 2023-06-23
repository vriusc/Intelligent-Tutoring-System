package com.example.demo.service;

import com.example.demo.entity.Questions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

/**
 * (Questions)表服务接口
 *
 * @author makejava
 * @since 2023-06-23 08:55:36
 */
public interface QuestionsService {

    /**
     * 通过ID查询单条数据
     *
     * @param questionId 主键
     * @return 实例对象
     */
    Questions queryById(Integer questionId);

    /**
     * 分页查询
     *
     * @param questions 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Questions> queryByPage(Questions questions, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param questions 实例对象
     * @return 实例对象
     */
    Questions insert(Questions questions);

    /**
     * 修改数据
     *
     * @param questions 实例对象
     * @return 实例对象
     */
    Questions update(Questions questions);

    /**
     * 通过主键删除数据
     *
     * @param questionId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer questionId);

}
