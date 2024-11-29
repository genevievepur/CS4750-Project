package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Assignment;
import com.cs4750.springbootproject.Repository.AssignmentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AssignmentService {
    private final AssignmentRepository repository;

    public AssignmentService(AssignmentRepository repository) {
        this.repository = repository;
    }

    // Get all assignments
    public List<Assignment> getAllAssignments() {
        return repository.findAll();
    }

    // Get an assignment by assignmentID
    public Optional<Assignment> getAssignmentByAssignmentID(String assignmentID) {
        return repository.findByAssignmentID(assignmentID);
    }

    // Add a new assignment
    public Assignment addAssignment(Assignment assignment) {
        if (repository.existsByAssignmentID(assignment.getAssignmentID())) {
            throw new RuntimeException("Assignment ID already in use!");
        }
        if (repository.existsByAssignmentTitle(assignment.getAssignmentTitle())) {
            throw new RuntimeException("Assignment title already in use!");
        }
        return repository.save(assignment);
    }

    // Update an existing assignment
    public Assignment updateAssignment(String assignmentID, Assignment updatedAssignment) {
        return repository.findByAssignmentID(assignmentID).map(assignment -> {
            assignment.setAssignmentID(updatedAssignment.getAssignmentID());
            assignment.setAssignmentTitle(updatedAssignment.getAssignmentTitle());
            assignment.setComments(updatedAssignment.getComments());
            assignment.setDueDate(updatedAssignment.getDueDate());
            assignment.setCompletionStatus(updatedAssignment.getCompletionStatus());
            assignment.setTypeID(updatedAssignment.getTypeID());
            return repository.save(assignment);
        }).orElseThrow(() -> new RuntimeException("Assignment not found with AssignmentID: " + assignmentID));
    }

    // Delete an assignment by AssignmentID
    public void deleteAssignment(String assignmentID) {
        Assignment assignment = repository.findByAssignmentID(assignmentID)
                .orElseThrow(() -> new RuntimeException("Assignment not found with AssignmentID: " + assignmentID));
        repository.delete(assignment);
    }
}
