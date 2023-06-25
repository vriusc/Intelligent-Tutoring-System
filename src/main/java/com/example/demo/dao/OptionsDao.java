package com.example.demo.dao;

import com.example.demo.entity.Options;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Options)表数据库访问层
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
@Mapper
public interface OptionsDao {

    /**
     * 通过ID查询单条数据
     *
     * @param optionId 主键
     * @return 实例对象
     */
    Options queryById(Integer optionId);

    /**
     * 查询指定行数据
     *
     * @param options 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Options> queryAllByLimit(@Param("options") Options options, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param options 查询条件
     * @return 总行数
     */
    long count(Options options);

    /**
     * 新增数据
     *
     * @param options 实例对象
     * @return 影响行数
     */
    int insert(Options options);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Options> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Options> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Options> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Options> entities);

    /**
     * 修改数据
     *
     * @param options 实例对象
     * @return 影响行数
     */
    int update(Options options);

    /**
     * 通过主键删除数据
     *
     * @param optionId 主键
     * @return 影响行数
     */
    int deleteById(Integer optionId);

}

