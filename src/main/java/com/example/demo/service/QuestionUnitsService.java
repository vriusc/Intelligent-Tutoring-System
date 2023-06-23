package com.example.demo.service;

import com.example.demo.entity.QuestionUnits;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (QuestionUnits)表服务接口
 *
 * @author makejava
 * @since 2023-06-23 09:31:50
 */
public interface QuestionUnitsService {

    /**
     * 通过ID查询单条数据
     *
     * @param questionUnitId 主键
     * @return 实例对象
     */
    QuestionUnits queryById(Integer questionUnitId);

    /**
     * 分页查询
     *
     * @param questionUnits 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<QuestionUnits> queryByPage(QuestionUnits questionUnits, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param questionUnits 实例对象
     * @return 实例对象
     */
    QuestionUnits insert(QuestionUnits questionUnits);

    /**
     * 修改数据
     *
     * @param questionUnits 实例对象
     * @return 实例对象
     */
    QuestionUnits update(QuestionUnits questionUnits);

    /**
     * 通过主键删除数据
     *
     * @param questionUnitId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer questionUnitId);

}
