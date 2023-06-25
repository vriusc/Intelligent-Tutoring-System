package com.example.demo.service.impl;

import com.example.demo.entity.Options;
import com.example.demo.dao.OptionsDao;
import com.example.demo.service.OptionsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import javax.annotation.Resource;

/**
 * (Options)表服务实现类
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
@Service("optionsService")
public class OptionsServiceImpl implements OptionsService {
    @Resource
    private OptionsDao optionsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param optionId 主键
     * @return 实例对象
     */
    @Override
    public Options queryById(Integer optionId) {
        return this.optionsDao.queryById(optionId);
    }

    /**
     * 分页查询
     *
     * @param options 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Options> queryByPage(Options options, Pageable pageRequest) {
        long total = this.optionsDao.count(options);
        return new PageImpl<>(this.optionsDao.queryAllByLimit(options, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param options 实例对象
     * @return 实例对象
     */
    @Override
    public Options insert(Options options) {
        this.optionsDao.insert(options);
        return options;
    }

    /**
     * 修改数据
     *
     * @param options 实例对象
     * @return 实例对象
     */
    @Override
    public Options update(Options options) {
        this.optionsDao.update(options);
        return this.queryById(options.getOptionId());
    }

    /**
     * 通过主键删除数据
     *
     * @param optionId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer optionId) {
        return this.optionsDao.deleteById(optionId) > 0;
    }
}
