package com.example.demo.service.impl;

import com.example.demo.entity.StudentUnits;
import com.example.demo.dao.StudentUnitsDao;
import com.example.demo.service.StudentUnitsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (StudentUnits)表服务实现类
 *
 * @author makejava
 * @since 2023-07-17 11:52:24
 */
@Service("studentUnitsService")
public class StudentUnitsServiceImpl implements StudentUnitsService {
    @Resource
    private StudentUnitsDao studentUnitsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param studentUnitId 主键
     * @return 实例对象
     */
    @Override
    public StudentUnits queryById(Integer studentUnitId) {
        return this.studentUnitsDao.queryById(studentUnitId);
    }

    /**
     * 分页查询
     *
     * @param studentUnits 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<StudentUnits> queryByPage(StudentUnits studentUnits, Pageable pageRequest) {
        long total = this.studentUnitsDao.count(studentUnits);
        return new PageImpl<>(this.studentUnitsDao.queryAllByLimit(studentUnits, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param studentUnits 实例对象
     * @return 实例对象
     */
    @Override
    public StudentUnits insert(StudentUnits studentUnits) {
        this.studentUnitsDao.insert(studentUnits);
        return studentUnits;
    }

    /**
     * 修改数据
     *
     * @param studentUnits 实例对象
     * @return 实例对象
     */
    @Override
    public StudentUnits update(StudentUnits studentUnits) {
        this.studentUnitsDao.update(studentUnits);
        return this.queryById(studentUnits.getStudentUnitId());
    }

    /**
     * 通过主键删除数据
     *
     * @param studentUnitId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer studentUnitId) {
        return this.studentUnitsDao.deleteById(studentUnitId) > 0;
    }
}
