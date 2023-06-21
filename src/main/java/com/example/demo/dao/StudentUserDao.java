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
     * 查询指定行数据
     *
     * @param studentUser 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<StudentUser> queryAllByLimit(StudentUser studentUser, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param studentUser 查询条件
     * @return 总行数
     */
    long count(StudentUser studentUser);

    /**
     * 新增数据
     *
     * @param studentUser 实例对象
     * @return 影响行数
     */
    int insert(StudentUser studentUser);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentUser> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<StudentUser> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentUser> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<StudentUser> entities);

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


}

