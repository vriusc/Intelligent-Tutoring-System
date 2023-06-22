package com.example.demo.dao;

import com.example.demo.entity.StudentSubjects;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (StudentSubjects)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-22 06:25:52
 */
@Mapper
public interface StudentSubjectsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param studentSubjectId 主键
     * @return 实例对象
     */
    StudentSubjects queryById(Integer studentSubjectId);

    /**
     * 查询指定行数据
     *
     * @param studentSubjects 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<StudentSubjects> queryAllByLimit(StudentSubjects studentSubjects, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param studentSubjects 查询条件
     * @return 总行数
     */
    long count(StudentSubjects studentSubjects);

    /**
     * 新增数据
     *
     * @param studentSubjects 实例对象
     * @return 影响行数
     */
    int insert(StudentSubjects studentSubjects);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentSubjects> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<StudentSubjects> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentSubjects> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<StudentSubjects> entities);

    /**
     * 修改数据
     *
     * @param studentSubjects 实例对象
     * @return 影响行数
     */
    int update(StudentSubjects studentSubjects);

    /**
     * 通过主键删除数据
     *
     * @param studentSubjectId 主键
     * @return 影响行数
     */
    int deleteById(Integer studentSubjectId);

}

