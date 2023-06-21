package com.example.demo.dao;

import com.example.demo.entity.Materials;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Materials)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
@Mapper
public interface MaterialsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param materialsId 主键
     * @return 实例对象
     */
    Materials queryById(Integer materialsId);

    /**
     * 查询指定行数据
     *
     * @param materials 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Materials> queryAllByLimit(Materials materials, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param materials 查询条件
     * @return 总行数
     */
    long count(Materials materials);

    /**
     * 新增数据
     *
     * @param materials 实例对象
     * @return 影响行数
     */
    int insert(Materials materials);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Materials> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Materials> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Materials> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Materials> entities);

    /**
     * 修改数据
     *
     * @param materials 实例对象
     * @return 影响行数
     */
    int update(Materials materials);

    /**
     * 通过主键删除数据
     *
     * @param materialsId 主键
     * @return 影响行数
     */
    int deleteById(Integer materialsId);

}

