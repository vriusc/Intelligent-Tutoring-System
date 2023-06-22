package com.example.demo.dao;

import com.example.demo.entity.Units;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Units)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-22 20:46:33
 */
@Mapper
public interface UnitsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param unitId 主键
     * @return 实例对象
     */
    Units queryById(Integer unitId);

    /**
     * 查询指定行数据
     *
     * @param units 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Units> queryAllByLimit(Units units, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param units 查询条件
     * @return 总行数
     */
    long count(Units units);

    /**
     * 新增数据
     *
     * @param units 实例对象
     * @return 影响行数
     */
    int insert(Units units);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Units> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Units> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Units> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Units> entities);

    /**
     * 修改数据
     *
     * @param units 实例对象
     * @return 影响行数
     */
    int update(Units units);

    /**
     * 通过主键删除数据
     *
     * @param unitId 主键
     * @return 影响行数
     */
    int deleteById(Integer unitId);


    /**
     * 通过subjectId查找对应全部数据
     *
     * @param subjectId 主键
     * @return 影响行数
     */
    List<Units> queryBySubjectId(Integer subjectId);

}

