package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Assignment;
import com.cs4750.springbootproject.Service.AssignmentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/assignments")
public class AssignmentController {
    private final AssignmentService assignmentService;

    public AssignmentController(AssignmentService assignmentService) {
        this.assignmentService = assignmentService;
    }

    // Get all assignments
    @GetMapping
    public ResponseEntity<List<Assignment>> getAllAssignments() {
        return ResponseEntity.ok(assignmentService.getAllAssignments());
    }

    // Get an assignment by assignmentID
    @GetMapping("/{assignmentID}")
    public ResponseEntity<Assignment> getAssignmentByAssignmentID(@PathVariable String assignmentID) {
        return assignmentService.getAssignmentByAssignmentID(assignmentID)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new assignment
    @PostMapping
    public ResponseEntity<Assignment> addAssignment(@RequestBody Assignment assignment) {
        try {
            return ResponseEntity.ok(assignmentService.addAssignment(assignment));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing assignment
    @PutMapping("/{assignmentID}")
    public ResponseEntity<Assignment> updateAssignment(@PathVariable String assignmentID, @RequestBody Assignment updatedAssignment) {
        try {
            return ResponseEntity.ok(assignmentService.updateAssignment(assignmentID, updatedAssignment));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete an assignment by assignmentID
    @DeleteMapping("/{assignmentID}")
    public ResponseEntity<Void> deleteAssignment(@PathVariable String assignmentID) {
        try {
            assignmentService.deleteAssignment(assignmentID);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
