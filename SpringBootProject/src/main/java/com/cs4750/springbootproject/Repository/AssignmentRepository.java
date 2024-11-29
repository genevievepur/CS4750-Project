package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AssignmentRepository extends JpaRepository<Assignment, String>{
    Optional<Assignment> findByAssignmentID(String assignmentID);

    boolean existsByAssignmentID(String assignmentID);

    boolean existsByAssignmentTitle(String assignmentTitle);
}
