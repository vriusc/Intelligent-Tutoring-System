package com.example.demo.service;

import com.example.demo.entity.Options;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (Options) table services interface
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
public interface OptionsService {

    /**
     * query By id
     *
     * @param optionId primary key
     * @return entity
     */
    Options queryById(Integer optionId);

    /**
     * query By limit
     *
     * @param options condition
     * @param pageRequest page request
     * @return entity list
     */
    Page<Options> queryByPage(Options options, Pageable pageRequest);

    /**
     * add new data
     *
     * @param options entity
     * @return entity
     */
    Options insert(Options options);

    /**
     * update data
     *
     * @param options entity
     * @return entity
     */
    Options update(Options options);

    /**
     * delete By id
     *
     * @param optionId primary key
     * @return boolean
     */
    boolean deleteById(Integer optionId);

}
