package com.example.demo.service.impl;

import com.example.demo.entity.Units;
import com.example.demo.dao.UnitsDao;
import com.example.demo.service.UnitsService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Units) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-22 20:46:33
 */
@Service("unitsService")
public class UnitsServiceImpl implements UnitsService {
    @Resource
    private UnitsDao unitsDao;

    /**
     * query By id
     *
     * @param unitId primary key
     * @return object
     */
    @Override
    public Units queryById(Integer unitId) {
        return this.unitsDao.queryById(unitId);
    }

    /**
     * query By limit
     *
     * @param units  condition
     * @param pageRequest page request
     * @return object list
     */
    @Override
    public Page<Units> queryByPage(Units units, PageRequest pageRequest) {
        long total = this.unitsDao.count(units);
        return new PageImpl<>(this.unitsDao.queryAllByLimit(units, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param units object
     * @return object
     */
    @Override
    public Units insert(Units units) {
        this.unitsDao.insert(units);
        return units;
    }

    /**
     * update data
     *
     * @param units object
     * @return object
     */
    @Override
    public Units update(Units units) {
        this.unitsDao.update(units);
        return this.queryById(units.getUnitId());
    }

    /**
     * delete By id
     *
     * @param unitId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer unitId) {
        return this.unitsDao.deleteById(unitId) > 0;
    }

    /**
     * query By subject id
     *
     * @param subjectID Primary key
     * @return object list
     */
    @Override
    public List<Units> queryBySubjectId(Integer subjectID) {
        return this.unitsDao.queryBySubjectId(subjectID);
    }


}
