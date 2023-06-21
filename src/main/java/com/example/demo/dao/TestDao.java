package com.example.demo.dao;

import com.example.demo.entity.Test;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Test)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-21 15:21:27
 */
@Mapper
public interface TestDao {

    /**
     * 通过ID查询单条数据
     *
     * @param testId 主键
     * @return 实例对象
     */
    Test queryById(Integer testId);

    /**
     * 查询指定行数据
     *
     * @param test 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Test> queryAllByLimit(Test test, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param test 查询条件
     * @return 总行数
     */
    long count(Test test);

    /**
     * 新增数据
     *
     * @param test 实例对象
     * @return 影响行数
     */
    int insert(Test test);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Test> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Test> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Test> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Test> entities);

    /**
     * 修改数据
     *
     * @param test 实例对象
     * @return 影响行数
     */
    int update(Test test);

    /**
     * 通过主键删除数据
     *
     * @param testId 主键
     * @return 影响行数
     */
    int deleteById(Integer testId);

}

