package com.example.demo.service;

import com.example.demo.entity.StudentUnits;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

/**
 * (StudentUnits)表服务接口
 *
 * @author makejava
 * @since 2023-07-17 11:52:24
 */
public interface StudentUnitsService {

    /**
     * 通过ID查询单条数据
     *
     * @param studentUnitId 主键
     * @return 实例对象
     */
    StudentUnits queryById(Integer studentUnitId);

    /**
     * 分页查询
     *
     * @param studentUnits 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<StudentUnits> queryByPage(StudentUnits studentUnits, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param studentUnits 实例对象
     * @return 实例对象
     */
    StudentUnits insert(StudentUnits studentUnits);

    /**
     * 修改数据
     *
     * @param studentUnits 实例对象
     * @return 实例对象
     */
    StudentUnits update(StudentUnits studentUnits);

    /**
     * 通过主键删除数据
     *
     * @param studentUnitId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer studentUnitId);

}
