package com.example.demo.service;

import com.example.demo.entity.Record;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Record)表服务接口
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
public interface RecordService {

    /**
     * 通过ID查询单条数据
     *
     * @param recordId 主键
     * @return 实例对象
     */
    Record queryById(Integer recordId);

    /**
     * 分页查询
     *
     * @param record 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Record> queryByPage(Record record, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param record 实例对象
     * @return 实例对象
     */
    Record insert(Record record);

    /**
     * 修改数据
     *
     * @param record 实例对象
     * @return 实例对象
     */
    Record update(Record record);

    /**
     * 通过主键删除数据
     *
     * @param recordId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer recordId);

}
