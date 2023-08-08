package com.example.demo.service.impl;

import com.example.demo.entity.StudentUnits;
import com.example.demo.dao.StudentUnitsDao;
import com.example.demo.service.StudentUnitsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import javax.annotation.Resource;

/**
 * (StudentUnits) table services implement class
 *
 * @author qianyongru
 * @since 2023-07-17 11:52:24
 */
@Service("studentUnitsService")
public class StudentUnitsServiceImpl implements StudentUnitsService {
    @Resource
    private StudentUnitsDao studentUnitsDao;

    /**
     * query By id
     *
     * @param studentUnitId primary key
     * @return object
     */
    @Override
    public StudentUnits queryById(Integer studentUnitId) {
        return this.studentUnitsDao.queryById(studentUnitId);
    }

    /**
     * query By limit
     *
     * @param studentUnits query condition
     * @param pageRequest page request
     * @return object list
     */
    @Override
    public Page<StudentUnits> queryByPage(StudentUnits studentUnits, Pageable pageRequest) {
        long total = this.studentUnitsDao.count(studentUnits);
        return new PageImpl<>(this.studentUnitsDao.queryAllByLimit(studentUnits, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param studentUnits object
     * @return object
     */
    @Override
    public StudentUnits insert(StudentUnits studentUnits) {
        this.studentUnitsDao.insert(studentUnits);
        return studentUnits;
    }

    /**
     * update data
     *
     * @param studentUnits object
     * @return object
     */
    @Override
    public StudentUnits update(StudentUnits studentUnits) {
        this.studentUnitsDao.update(studentUnits);
        return this.queryById(studentUnits.getStudentUnitId());
    }

    /**
     * delete By id
     *
     * @param studentUnitId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer studentUnitId) {
        return this.studentUnitsDao.deleteById(studentUnitId) > 0;
    }
}
