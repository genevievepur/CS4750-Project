package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Course;
import com.cs4750.springbootproject.Service.CourseService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/courses")
public class CourseController {
    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    // Get all classes
    @GetMapping
    public ResponseEntity<List<Course>> getAllCourses() {
        return ResponseEntity.ok(courseService.getAllCourses());
    }

    // Get a class by class_id
    @GetMapping("/{course_id}")
    public ResponseEntity<Course> getStudentByCourseID(@PathVariable String course_id) {
        return courseService.getCourseByCourseID(course_id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new class
    @PostMapping
    public ResponseEntity<Course> addCourse(@RequestBody Course course) {
        try {
            return ResponseEntity.ok(courseService.addCourse(course));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing class
    @PutMapping("/{course_id}")
    public ResponseEntity<Course> updateCourse(@PathVariable String course_id, @RequestBody Course updatedCourse) {
        try {
            return ResponseEntity.ok(courseService.updateCourse(course_id, updatedCourse));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete a class by course_id
    @DeleteMapping("/{course_id}")
    public ResponseEntity<Void> deleteCourse(@PathVariable String course_id) {
        try {
            courseService.deleteCourse(course_id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}