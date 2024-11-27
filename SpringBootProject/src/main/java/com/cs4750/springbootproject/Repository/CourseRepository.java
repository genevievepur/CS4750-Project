package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CourseRepository extends JpaRepository<Course, String> {
    Optional<Course> findByCourseID(String course_id);

    boolean existsByCourseID(String course_id);

    boolean existsByCourseName(String courseName);
}