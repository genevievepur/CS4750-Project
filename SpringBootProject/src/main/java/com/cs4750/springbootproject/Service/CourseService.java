package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Course;
import com.cs4750.springbootproject.Repository.CourseRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
    private final CourseRepository repository;

    public CourseService(CourseRepository repository) {
        this.repository = repository;
    }

    // Get all classes
    public List<Course> getAllCourses() {
        return repository.findAll();
    }

    // Get a class by class_id
    public Optional<Course> getCourseByCourseID(String course_id) {
        return repository.findByCourseID(course_id);
    }

    // Add a new class
    public Course addCourse(Course course) {
        if (repository.existsByCourseID(course.getCourseID())) {
            throw new RuntimeException("ClassID already in use!");
        }
        if (repository.existsByCourseName(course.getCourseName())) {
            throw new RuntimeException("Class name already in use!");
        }
        return repository.save(course);
    }

    // Update an existing class
    public Course updateCourse(String course_id, Course updatedCourse) {
        return repository.findByCourseID(course_id).map(course -> {
            course.setCourseID(updatedCourse.getCourseID());
            course.setCourseName(updatedCourse.getCourseName());
            course.setLocation(updatedCourse.getLocation());
            course.setMeetingTime(updatedCourse.getMeetingTime());
            return repository.save(course);
        }).orElseThrow(() -> new RuntimeException("Class not found with ClassID: " + course_id));
    }

    // Delete a class by ClassID
    public void deleteCourse(String class_id) {
        Course course = repository.findByCourseID(class_id)
                .orElseThrow(() -> new RuntimeException("Class not found with ClassID: " + class_id));
        repository.delete(course);
    }
}