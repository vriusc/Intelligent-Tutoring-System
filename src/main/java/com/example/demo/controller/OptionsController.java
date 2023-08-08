package com.example.demo.controller;

import com.example.demo.entity.Options;
import com.example.demo.service.OptionsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Options) controller
 *
 * @author qianyongru
 * @since 2023-06-23 10:58:28
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/options")
public class OptionsController {
    /**
     * optionsService
     */
    @Resource
    private OptionsService optionsService;

    /**
     * page query
     *
     * @param options condition
     * @param pageRequest pageRequest
     * @return Page<Options>
     */
    @GetMapping
    public ResponseEntity<Page<Options>> queryByPage(Options options, Pageable pageRequest) {
        return ResponseEntity.ok(this.optionsService.queryByPage(options, pageRequest));
    }

    /**
     * query by id
     *
     * @param id id
     * @return Options
     */
    @GetMapping("{id}")
    public ResponseEntity<Options> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.optionsService.queryById(id));
    }

    /**
     * add data
     *
     * @param options entity
     * @return Options
     */
    @PostMapping
    public ResponseEntity<Options> add(Options options) {
        return ResponseEntity.ok(this.optionsService.insert(options));
    }

    /**
     * edit data
     *
     * @param options entity
     * @return Options
     */
    @PutMapping
    public ResponseEntity<Options> edit(Options options) {
        return ResponseEntity.ok(this.optionsService.update(options));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return Boolean
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.optionsService.deleteById(id));
    }

}

