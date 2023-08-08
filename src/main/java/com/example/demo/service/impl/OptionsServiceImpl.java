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
 * (Options) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
@Service("optionsService")
public class OptionsServiceImpl implements OptionsService {
    @Resource
    private OptionsDao optionsDao;

    /**
     * query By id
     *
     * @param optionId primary key
     * @return entity
     */
    @Override
    public Options queryById(Integer optionId) {
        return this.optionsDao.queryById(optionId);
    }

    /**
     * query By limit
     *
     * @param options condition
     * @param pageRequest page request
     * @return entity list
     */
    @Override
    public Page<Options> queryByPage(Options options, Pageable pageRequest) {
        long total = this.optionsDao.count(options);
        return new PageImpl<>(this.optionsDao.queryAllByLimit(options, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param options entity
     * @return entity
     */
    @Override
    public Options insert(Options options) {
        this.optionsDao.insert(options);
        return options;
    }

    /**
     * update data
     *
     * @param options entity
     * @return entity
     */
    @Override
    public Options update(Options options) {
        this.optionsDao.update(options);
        return this.queryById(options.getOptionId());
    }

    /**
     * delete By id
     *
     * @param optionId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer optionId) {
        return this.optionsDao.deleteById(optionId) > 0;
    }
}
