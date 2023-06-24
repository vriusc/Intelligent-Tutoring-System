package com.example.demo.service.impl;

import com.example.demo.entity.Record;
import com.example.demo.dao.RecordDao;
import com.example.demo.service.RecordService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;

import javax.annotation.Resource;

/**
 * (Record)表服务实现类
 *
 * @author makejava
 * @since 2023-06-23 19:27:35
 */
@Service("recordService")
public class RecordServiceImpl implements RecordService {
    @Resource
    private RecordDao recordDao;

    /**
     * 通过ID查询单条数据
     *
     * @param recordId 主键
     * @return 实例对象
     */
    @Override
    public Record queryById(Integer recordId) {
        return this.recordDao.queryById(recordId);
    }

    /**
     * 分页查询
     *
     * @param record 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Record> queryByPage(Record record, Pageable pageRequest) {
        long total = this.recordDao.count(record);
        return new PageImpl<>(this.recordDao.queryAllByLimit(record, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param record 实例对象
     * @return 实例对象
     */
    @Override
    public Record insert(Record record) {
        this.recordDao.insert(record);
        return record;
    }

    /**
     * 修改数据
     *
     * @param record 实例对象
     * @return 实例对象
     */
    @Override
    public Record update(Record record) {
        this.recordDao.update(record);
        return this.queryById(record.getRecordId());
    }

    /**
     * 通过主键删除数据
     *
     * @param recordId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer recordId) {
        return this.recordDao.deleteById(recordId) > 0;
    }
}
