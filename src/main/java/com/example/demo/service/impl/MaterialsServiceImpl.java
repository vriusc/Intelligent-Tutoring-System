package com.example.demo.service.impl;

import com.example.demo.entity.Materials;
import com.example.demo.dao.MaterialsDao;
import com.example.demo.service.MaterialsService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (Materials)表服务实现类
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
@Service("materialsService")
public class MaterialsServiceImpl implements MaterialsService {
    @Resource
    private MaterialsDao materialsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param materialsId 主键
     * @return 实例对象
     */
    @Override
    public Materials queryById(Integer materialsId) {
        return this.materialsDao.queryById(materialsId);
    }

    /**
     * 分页查询
     *
     * @param materials 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Materials> queryByPage(Materials materials, PageRequest pageRequest) {
        long total = this.materialsDao.count(materials);
        return new PageImpl<>(this.materialsDao.queryAllByLimit(materials, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param materials 实例对象
     * @return 实例对象
     */
    @Override
    public Materials insert(Materials materials) {
        this.materialsDao.insert(materials);
        return materials;
    }

    /**
     * 修改数据
     *
     * @param materials 实例对象
     * @return 实例对象
     */
    @Override
    public Materials update(Materials materials) {
        this.materialsDao.update(materials);
        return this.queryById(materials.getMaterialsId());
    }

    /**
     * 通过主键删除数据
     *
     * @param materialsId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer materialsId) {
        return this.materialsDao.deleteById(materialsId) > 0;
    }
}
