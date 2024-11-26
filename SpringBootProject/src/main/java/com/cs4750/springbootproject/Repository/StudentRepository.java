package com.cs4750.springbootproject.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cs4750.springbootproject.Model.Student;

public interface StudentRepository extends JpaRepository<Student,Long>{

    List<Student> findStudentBy(String name);

    // Find all students with usernames containing a given substring
    List<Student> findByUsernameContaining(String username);

    // Find all students whose name contains a specific keyword
    List<Student> findByNameContaining(String name);

    // Find students by exact email match
    Student findByEmail(String email);

    // Find students whose email contains a specific domain
    List<Student> findByEmailContaining(String email);
}
