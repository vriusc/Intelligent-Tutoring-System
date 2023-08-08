package com.example.demo.dao;

import com.example.demo.entity.StudentUnits;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (StudentUnits) table dao
 *
 * @author qianyongru
 * @since 2023-07-17 11:52:24
 */

@Mapper
public interface StudentUnitsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param studentUnitId 主键
     * @return 实例对象
     */
    StudentUnits queryById(Integer studentUnitId);

    /**
     * 查询指定行数据
     *
     * @param studentUnits 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<StudentUnits> queryAllByLimit(@Param("studentUnits") StudentUnits studentUnits, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param studentUnits 查询条件
     * @return 总行数
     */
    long count(StudentUnits studentUnits);

    /**
     * 新增数据
     *
     * @param studentUnits 实例对象
     * @return 影响行数
     */
    int insert(StudentUnits studentUnits);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentUnits> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<StudentUnits> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<StudentUnits> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<StudentUnits> entities);

    /**
     * 修改数据
     *
     * @param studentUnits 实例对象
     * @return 影响行数
     */
    int update(StudentUnits studentUnits);

    /**
     * 通过主键删除数据
     *
     * @param studentUnitId 主键
     * @return 影响行数
     */
    int deleteById(Integer studentUnitId);

}

