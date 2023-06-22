package com.example.demo.dao;

import com.example.demo.entity.Subjects;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Subjects)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-22 06:24:38
 */
@Mapper
public interface SubjectsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param subjectId 主键
     * @return 实例对象
     */
    Subjects queryById(Integer subjectId);

    /**
     * 查询指定行数据
     *
     * @param subjects 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Subjects> queryAllByLimit(Subjects subjects, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param subjects 查询条件
     * @return 总行数
     */
    long count(Subjects subjects);

    /**
     * 新增数据
     *
     * @param subjects 实例对象
     * @return 影响行数
     */
    int insert(Subjects subjects);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Subjects> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Subjects> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Subjects> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Subjects> entities);

    /**
     * 修改数据
     *
     * @param subjects 实例对象
     * @return 影响行数
     */
    int update(Subjects subjects);

    /**
     * 通过主键删除数据
     *
     * @param subjectId 主键
     * @return 影响行数
     */
    int deleteById(Integer subjectId);

}

