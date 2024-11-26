
package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Student;
import com.cs4750.springbootproject.Repository.StudentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentService {
    private final StudentRepository repository;

    public StudentService(StudentRepository repository) {
        this.repository = repository;
    }

    // Get all students
    public List<Student> getAllStudents() {
        return repository.findAll();
    }

    // Get a student by username
    public Optional<Student> getStudentByUsername(String username) {
        return repository.findByUsername(username);
    }

    // Add a new student
    public Student addStudent(Student student) {
        if (repository.existsByEmail(student.getEmail())) {
            throw new RuntimeException("Email already in use!");
        }
        if (repository.existsByUsername(student.getUsername())) {
            throw new RuntimeException("Username already in use!");
        }
        return repository.save(student);
    }

    // Update an existing student
    public Student updateStudent(String username, Student updatedStudent) {
        return repository.findByUsername(username).map(student -> {
            student.setPassword(updatedStudent.getPassword());
            student.setEmail(updatedStudent.getEmail());
            student.setName(updatedStudent.getName());
            return repository.save(student);
        }).orElseThrow(() -> new RuntimeException("Student not found with username: " + username));
    }

    // Delete a student by username
    public void deleteStudent(String username) {
        Student student = repository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Student not found with username: " + username));
        repository.delete(student);
    }
}
