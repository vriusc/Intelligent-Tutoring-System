package com.example.demo.dao;

import com.example.demo.entity.Questions;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Questions)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-23 08:55:36
 */
@Mapper
public interface QuestionsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param questionId 主键
     * @return 实例对象
     */
    Questions queryById(Integer questionId);

    /**
     * 查询指定行数据
     *
     * @param questions 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Questions> queryAllByLimit(@Param("Questions") Questions questions, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param questions 查询条件
     * @return 总行数
     */
    long count(Questions questions);

    /**
     * 新增数据
     *
     * @param questions 实例对象
     * @return 影响行数
     */
    int insert(Questions questions);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Questions> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Questions> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Questions> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Questions> entities);

    /**
     * 修改数据
     *
     * @param questions 实例对象
     * @return 影响行数
     */
    int update(Questions questions);

    /**
     * 通过主键删除数据
     *
     * @param questionId 主键
     * @return 影响行数
     */
    int deleteById(Integer questionId);

}

