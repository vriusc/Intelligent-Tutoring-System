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
import java.util.List;

/**
 * (StudentSubjects) controller
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/studentSubjects")
public class StudentSubjectsController {


    @Resource
    private StudentSubjectsService studentSubjectsService;

    @Resource
    private StudentUserServiceImpl studentUserService;
    @Resource
    private SubjectsServiceImpl subjectsService;


    /**
     * studentSubjects
     */
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
     * query all data
     *
     * @param studentSubjects condition
     * @param pageRequest    pageRequest
     * @return Page<StudentSubjects>
     */
    @GetMapping
    public ResponseEntity<Page<StudentSubjects>> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest) {
        return ResponseEntity.ok(this.studentSubjectsService.queryByPage(studentSubjects, pageRequest));
    }


    /**
     * query all data
     *
     * @param id condition
     * @return Page<StudentSubjects>
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentSubjects> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentSubjectsService.queryById(id));
    }

    /**
     * add data
     *
     * @param studentSubjects entity
     * @return StudentSubjects
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
     * edit data
     *
     * @param studentSubjects entity
     * @return StudentSubjects
     */
    @PutMapping
    public ResponseEntity<StudentSubjects> edit(@RequestBody StudentSubjects studentSubjects) {
        return ResponseEntity.ok(this.studentSubjectsService.update(studentSubjects));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return Boolean
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

