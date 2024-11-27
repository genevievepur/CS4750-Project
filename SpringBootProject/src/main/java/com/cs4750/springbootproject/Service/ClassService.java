package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Class;
import com.cs4750.springbootproject.Repository.ClassRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClassService {
    private final ClassRepository repository;

    public ClassService(ClassRepository repository) {
        this.repository = repository;
    }

    // Get all classes
    public List<Class> getAllClasses() {
        return repository.findAll();
    }

    // Get a class by class_id
    public Optional<Class> getClassByClassID(String class_id) {
        return repository.findClassByID(class_id);
    }

    // Add a new class
    public Class addClass(Class class) {
        if (repository.existsByID(class.getClassID())) {
            throw new RuntimeException("ClassID already in use!");
        }
        if (repository.existsByName(class.getClassName())) {
            throw new RuntimeException("Class name already in use!");
        }
        return repository.save(class);
    }

    // Update an existing class
    public Class updateClass(String class_id, Class updatedClass) {
        return repository.findByClassID(class_id).map(class -> {
            class.setClassID(updatedClass.getClassID());
            class.setClassName(updatedClass.getClassName());
            class.setLocation(updatedClass.getLocation());
            class.setMeetingTime(updatedClass.getMeetingTime());
            return repository.save(class);
        }).orElseThrow(() -> new RuntimeException("Class not found with ClassID: " + id));
    }

    // Delete a class by ClassID
    public void deleteClass(String class_id) {
        Class class = repository.findByClassID(class_id)
                .orElseThrow(() -> new RuntimeException("Class not found with ClassID: " + class_id);
        repository.delete(class);
    }
}