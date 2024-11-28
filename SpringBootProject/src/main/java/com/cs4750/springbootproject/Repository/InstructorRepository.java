package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface InstructorRepository extends JpaRepository<Instructor, String> {

    // Find an instructor by their ID
    Optional<Instructor> findById(String id);

    // Check if an instructor exists by their ID
    boolean existsById(String id);

    // Check if an instructor exists by their email
    boolean existsByEmail(String email);
}
