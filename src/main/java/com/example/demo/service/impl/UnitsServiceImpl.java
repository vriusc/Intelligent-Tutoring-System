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
 * (Units)表服务实现类
 *
 * @author makejava
 * @since 2023-06-22 20:46:33
 */
@Service("unitsService")
public class UnitsServiceImpl implements UnitsService {
    @Resource
    private UnitsDao unitsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param unitId 主键
     * @return 实例对象
     */
    @Override
    public Units queryById(Integer unitId) {
        return this.unitsDao.queryById(unitId);
    }

    /**
     * 分页查询
     *
     * @param units 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Units> queryByPage(Units units, PageRequest pageRequest) {
        long total = this.unitsDao.count(units);
        return new PageImpl<>(this.unitsDao.queryAllByLimit(units, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param units 实例对象
     * @return 实例对象
     */
    @Override
    public Units insert(Units units) {
        this.unitsDao.insert(units);
        return units;
    }

    /**
     * 修改数据
     *
     * @param units 实例对象
     * @return 实例对象
     */
    @Override
    public Units update(Units units) {
        this.unitsDao.update(units);
        return this.queryById(units.getUnitId());
    }

    /**
     * 通过主键删除数据
     *
     * @param unitId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer unitId) {
        return this.unitsDao.deleteById(unitId) > 0;
    }

    /**
     * 通过subjectId查询数据
     *
     * @param subjectID 主键
     * @return 操作结果
     */
    @Override
    public List<Units> queryBySubjectId(Integer subjectID) {
        return this.unitsDao.queryBySubjectId(subjectID);
    }


}
