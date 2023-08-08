package com.example.demo.service;

import com.example.demo.entity.Record;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Record) table services interface
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
public interface RecordService {

    /**
     * query By id
     *
     * @param recordId primary key
     * @return entity
     */
    Record queryById(Integer recordId);

    /**
     * query By limit
     *
     * @param record condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<Record> queryByPage(Record record, Pageable pageRequest);

    /**
     * add new data
     *
     * @param record entity
     * @return entity
     */
    Record insert(Record record);

    /**
     * update data
     *
     * @param record entity
     * @return entity
     */
    Record update(Record record);

    /**
     * delete By id
     *
     * @param recordId primary key
     * @return boolean
     */
    boolean deleteById(Integer recordId);

}
