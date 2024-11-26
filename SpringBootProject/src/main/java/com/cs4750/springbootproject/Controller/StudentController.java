package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Student;
import com.cs4750.springbootproject.Service.StudentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/students")
public class StudentController {
    private final StudentService studentService;

    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    // Get all students
    @GetMapping
    public ResponseEntity<List<Student>> getAllStudents() {
        return ResponseEntity.ok(studentService.getAllStudents());
    }

    // Get a student by username
    @GetMapping("/{username}")
    public ResponseEntity<Student> getStudentByUsername(@PathVariable String username) {
        return studentService.getStudentByUsername(username)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new student
    @PostMapping
    public ResponseEntity<Student> addStudent(@RequestBody Student student) {
        try {
            return ResponseEntity.ok(studentService.addStudent(student));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing student
    @PutMapping("/{username}")
    public ResponseEntity<Student> updateStudent(@PathVariable String username, @RequestBody Student updatedStudent) {
        try {
            return ResponseEntity.ok(studentService.updateStudent(username, updatedStudent));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete a student by username
    @DeleteMapping("/{username}")
    public ResponseEntity<Void> deleteStudent(@PathVariable String username) {
        try {
            studentService.deleteStudent(username);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
