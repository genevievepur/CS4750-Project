
package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StudentRepository extends JpaRepository<Student, String> {
    Optional<Student> findByUsername(String username);

    boolean existsByEmail(String email);

    boolean existsByUsername(String username);
}
