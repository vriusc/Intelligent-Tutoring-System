package com.example.demo.dao;

import com.example.demo.entity.TestListeningJudgementByPicture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (TestListeningJudgementByPicture)表数据库访问层
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
@Mapper
public interface TestListeningJudgementByPictureDao {

    /**
     * 通过ID查询单条数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 实例对象
     */
    TestListeningJudgementByPicture queryById(Integer testListeningJudgementByPictureId);

    /**
     * 查询指定行数据
     *
     * @param testListeningJudgementByPicture 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<TestListeningJudgementByPicture> queryAllByLimit(TestListeningJudgementByPicture testListeningJudgementByPicture, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param testListeningJudgementByPicture 查询条件
     * @return 总行数
     */
    long count(TestListeningJudgementByPicture testListeningJudgementByPicture);

    /**
     * 新增数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 影响行数
     */
    int insert(TestListeningJudgementByPicture testListeningJudgementByPicture);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<TestListeningJudgementByPicture> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<TestListeningJudgementByPicture> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<TestListeningJudgementByPicture> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<TestListeningJudgementByPicture> entities);

    /**
     * 修改数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 影响行数
     */
    int update(TestListeningJudgementByPicture testListeningJudgementByPicture);

    /**
     * 通过主键删除数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 影响行数
     */
    int deleteById(Integer testListeningJudgementByPictureId);

}

