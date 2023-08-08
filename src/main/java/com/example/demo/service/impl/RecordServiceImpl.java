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
 * (Record) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
@Service("recordService")
public class RecordServiceImpl implements RecordService {
    @Resource
    private RecordDao recordDao;

    /**
     * query By id
     *
     * @param recordId primary key
     * @return entity
     */
    @Override
    public Record queryById(Integer recordId) {
        return this.recordDao.queryById(recordId);
    }

    /**
     * query By limit
     *
     * @param record query condition
     * @param pageRequest page request
     * @return entity list
     */
    @Override
    public Page<Record> queryByPage(Record record, Pageable pageRequest) {
        long total = this.recordDao.count(record);
        return new PageImpl<>(this.recordDao.queryAllByLimit(record, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param record entity
     * @return entity
     */
    @Override
    public Record insert(Record record) {
        this.recordDao.insert(record);
        return record;
    }

    /**
     * update data
     *
     * @param record entity
     * @return entity
     */
    @Override
    public Record update(Record record) {
        this.recordDao.update(record);
        return this.queryById(record.getRecordId());
    }

    /**
     * delete By id
     *
     * @param recordId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer recordId) {
        return this.recordDao.deleteById(recordId) > 0;
    }
}
