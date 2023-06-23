package com.example.demo.dao;

import com.example.demo.entity.QuestionTypes;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (QuestionTypes)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-23 08:12:09
 */
@Mapper
public interface QuestionTypesDao {

    /**
     * 通过ID查询单条数据
     *
     * @param questionTypeId 主键
     * @return 实例对象
     */
    QuestionTypes queryById(Integer questionTypeId);

    /**
     * 查询指定行数据
     *
     * @param questionTypes 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<QuestionTypes> queryAllByLimit(@Param("questionTypes") QuestionTypes questionTypes, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param questionTypes 查询条件
     * @return 总行数
     */
    long count(QuestionTypes questionTypes);

    /**
     * 新增数据
     *
     * @param questionTypes 实例对象
     * @return 影响行数
     */
    int insert(QuestionTypes questionTypes);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<QuestionTypes> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<QuestionTypes> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<QuestionTypes> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<QuestionTypes> entities);

    /**
     * 修改数据
     *
     * @param questionTypes 实例对象
     * @return 影响行数
     */
    int update(QuestionTypes questionTypes);

    /**
     * 通过主键删除数据
     *
     * @param questionTypeId 主键
     * @return 影响行数
     */
    int deleteById(Integer questionTypeId);

}

