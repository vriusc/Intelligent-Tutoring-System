package com.example.demo.service;

import com.example.demo.entity.StudentUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (StudentUser)表服务接口
 *
 * @author makejava
 * @since 2023-06-21 06:36:40
 */
public interface StudentUserService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    StudentUser queryById(Integer id);

    /**
     * 分页查询
     *
     * @param studentUser 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<StudentUser> queryByPage(StudentUser studentUser, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param studentUser 实例对象
     * @return 实例对象
     */
    StudentUser insert(StudentUser studentUser);

    /**
     * 修改数据
     *
     * @param studentUser 实例对象
     * @return 实例对象
     */
    StudentUser update(StudentUser studentUser);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

}
