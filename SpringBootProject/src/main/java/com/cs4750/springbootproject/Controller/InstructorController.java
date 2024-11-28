package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Instructor;
import com.cs4750.springbootproject.Service.InstructorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/instructors")
public class InstructorController {
    private final InstructorService instructorService;

    // Constructor injection for InstructorService
    public InstructorController(InstructorService instructorService) {
        this.instructorService = instructorService;
    }

    // Get all instructors
    @GetMapping
    public ResponseEntity<List<Instructor>> getAllInstructors() {
        return ResponseEntity.ok(instructorService.getAllInstructors());
    }

    // Get an instructor by InstructorID
    @GetMapping("/{instructorID}")
    public ResponseEntity<Instructor> getInstructorById(@PathVariable String instructorID) {
        return instructorService.getInstructorById(instructorID)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new instructor
    @PostMapping
    public ResponseEntity<Instructor> addInstructor(@RequestBody Instructor instructor) {
        try {
            return ResponseEntity.ok(instructorService.addInstructor(instructor));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing instructor
    @PutMapping("/{instructorID}")
    public ResponseEntity<Instructor> updateInstructor(@PathVariable String instructorID, @RequestBody Instructor updatedInstructor) {
        try {
            return ResponseEntity.ok(instructorService.updateInstructor(instructorID, updatedInstructor));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete an instructor by InstructorID
    @DeleteMapping("/{instructorID}")
    public ResponseEntity<Void> deleteInstructor(@PathVariable String instructorID) {
        try {
            instructorService.deleteInstructor(instructorID);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
