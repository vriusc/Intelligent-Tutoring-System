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
     * @return 对象列表
     */
    List<Units> queryBySubjectId(Integer subjectId);

}

