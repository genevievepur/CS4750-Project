package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Instructor;
import com.cs4750.springbootproject.Repository.InstructorRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InstructorService {
    private final InstructorRepository repository;

    // Constructor injection for the repository
    public InstructorService(InstructorRepository repository) {
        this.repository = repository;
    }

    // Get all instructors
    public List<Instructor> getAllInstructors() {
        return repository.findAll();
    }

    // Get an instructor by InstructorID
    public Optional<Instructor> getInstructorById(String instructorID) {
        return repository.findById(instructorID);
    }

    // Add a new instructor
    public Instructor addInstructor(Instructor instructor) {
        // Check if the instructor ID already exists
        if (repository.existsById(instructor.getId())) {
            throw new RuntimeException("Instructor ID already in use!");
        }
        // Check if the instructor email already exists
        if (repository.existsByEmail(instructor.getEmail())) {
            throw new RuntimeException("Instructor email already in use!");
        }
        // Save and return the new instructor
        return repository.save(instructor);
    }

    // Update an existing instructor
    public Instructor updateInstructor(String instructorID, Instructor updatedInstructor) {
        // Find the instructor by ID and update the fields
        return repository.findById(instructorID).map(instructor -> {
            instructor.setId(updatedInstructor.getId());
            instructor.setName(updatedInstructor.getName());
            instructor.setEmail(updatedInstructor.getEmail());
            return repository.save(instructor);
        }).orElseThrow(() -> new RuntimeException("Instructor not found with ID: " + instructorID));
    }

    // Delete an instructor by InstructorID
    public void deleteInstructor(String instructorID) {
        // Find the instructor and delete
        Instructor instructor = repository.findById(instructorID)
                .orElseThrow(() -> new RuntimeException("Instructor not found with ID: " + instructorID));
        repository.delete(instructor);
    }
}
