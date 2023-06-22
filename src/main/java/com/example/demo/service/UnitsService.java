package com.example.demo.service;

import com.example.demo.entity.Units;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

/**
 * (Units)表服务接口
 *
 * @author makejava
 * @since 2023-06-22 20:46:33
 */
public interface UnitsService {

    /**
     * 通过ID查询单条数据
     *
     * @param unitId 主键
     * @return 实例对象
     */
    Units queryById(Integer unitId);

    /**
     * 分页查询
     *
     * @param units 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Units> queryByPage(Units units, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param units 实例对象
     * @return 实例对象
     */
    Units insert(Units units);

    /**
     * 修改数据
     *
     * @param units 实例对象
     * @return 实例对象
     */
    Units update(Units units);

    /**
     * 通过主键删除数据
     *
     * @param unitId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer unitId);

    /**
     * 通过subjectId查询数据
     *
     * @param subjectID 主键
     * @return 操作结果
     */
    List<Units> queryBySubjectId(Integer subjectID);


}
