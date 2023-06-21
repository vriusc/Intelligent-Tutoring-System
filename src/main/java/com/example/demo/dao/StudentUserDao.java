package com.example.demo.dao;

import com.example.demo.entity.StudentUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (StudentUser)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-21 06:36:40
 */
@Mapper
public interface StudentUserDao {
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
     * @return 影响行数
     */

    int insert(StudentUser studentUser);

    /**
     * 查询指定行数据
     *
     * @param studentUser 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<StudentUser> queryAllByLimit(StudentUser studentUser, @Param("pageable") Pageable pageable);

    /**
     * 修改数据
     *
     * @param studentUser 实例对象
     * @return 影响行数
     */
    int update(StudentUser studentUser);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

    /**
     * 查询用户名是否存在
     *
     * @param username 用户名
     * @return username
     */
    String queryByUsername(String username);

    /**
     * 查询邮箱是否存在
     *
     * @param email 邮箱
     * @return email
     */
    String queryByEmail(String email);


    /**
     * @param username 用户名
     * @return 用户对象
     */
    StudentUser findByUsername(String username);

    /**
     * @param email 邮箱
     * @return 用户对象
     */

    StudentUser findByEmail(String email);
}

