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
     * 新增数据
     *
     * @param studentUser 实例对象
     * @return 实例对象
     */
    StudentUser insert(StudentUser studentUser);

    /**
     * 用户登陆
     *
     * @param usernameOrEmail 用户名或邮箱
     * @param password 密码
     * @return 实例对象
     */

    StudentUser login(String usernameOrEmail, String password);

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
