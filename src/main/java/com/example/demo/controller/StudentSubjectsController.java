package com.example.demo.controller;

import com.example.demo.entity.*;
import com.example.demo.service.StudentSubjectsService;
import com.example.demo.service.impl.StudentUserServiceImpl;
import com.example.demo.service.impl.SubjectsServiceImpl;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * (StudentSubjects)表控制层
 *
 * @author makejava
 * @since 2023-06-22 06:25:52
 */
@RestController
@RequestMapping("studentSubjects")
public class StudentSubjectsController {


    /**
     * 服务对象
     */
    @Resource
    private StudentSubjectsService studentSubjectsService;

    @Resource
    private StudentUserServiceImpl studentUserService;
    @Resource
    private SubjectsServiceImpl subjectsService;

    // 在这里添加convertToDTO方法
    private StudentSubjectsDTO convertToDTO(StudentSubjects studentSubjects, RegisterResponseDTO studentDTO, Subjects subject) {
        StudentSubjectsDTO dto = new StudentSubjectsDTO();
        dto.setStudentSubjectId(studentSubjects.getStudentSubjectId());
        dto.setStudentId(studentSubjects.getStudentId());
        dto.setSubjectId(studentSubjects.getSubjectId());
        dto.setProgress(studentSubjects.getProgress());
        dto.setStudent(studentDTO);  // 设置StudentDTO，不包含密码
        dto.setSubject(subject);     // 设置Subject

        return dto;
    }

    /**
     * 分页查询
     *
     * @param studentSubjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<StudentSubjects>> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest) {
        return ResponseEntity.ok(this.studentSubjectsService.queryByPage(studentSubjects, pageRequest));
    }


    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentSubjects> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentSubjectsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param studentSubjects 实体
     * @return 新增结果
     */
    @PostMapping("/add")
    public ResponseEntity<StudentSubjectsDTO> add(@RequestBody StudentSubjects studentSubjects) {
        // Call the insert method to save the studentSubjects object
        StudentSubjects insertedStudentSubjects = this.studentSubjectsService.insert(studentSubjects);

        // Query the student and subject from their respective services
        StudentUser student = studentUserService.queryById(insertedStudentSubjects.getStudentId());
        Subjects subject = subjectsService.queryById(insertedStudentSubjects.getSubjectId());

        if (student == null || subject == null) {
            throw new RuntimeException("Student or Subject not found.");
        }

        // Convert StudentUser to RegisterResponseDTO
        RegisterResponseDTO studentDTO = new RegisterResponseDTO();
        studentDTO.setId(student.getId());
        studentDTO.setUsername(student.getUsername());
        studentDTO.setEmail(student.getEmail());

        // Convert insertedStudentSubjects, studentDTO and subject to StudentSubjectsDTO
        StudentSubjectsDTO dto =convertToDTO(insertedStudentSubjects, studentDTO, subject);

        // Return the dto
        return ResponseEntity.ok(dto);
    }


    /**
     * 编辑数据
     *
     * @param studentSubjects 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<StudentSubjects> edit(StudentSubjects studentSubjects) {
        return ResponseEntity.ok(this.studentSubjectsService.update(studentSubjects));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentSubjectsService.deleteById(id));
    }

    @GetMapping("/queryByStudentId/{studentId}")
    public List<StudentSubjects> queryByStudentId(@PathVariable Integer studentId) {
        return studentSubjectsService.queryByStudentId(studentId);
    }



}

