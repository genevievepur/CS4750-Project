package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Class;
import com.cs4750.springbootproject.Service.ClassService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/classes")
public class ClassController {
    private final ClassService classService;

    public ClassController(ClassService classService) {
        this.classService = classService;
    }

    // Get all classes
    @GetMapping
    public ResponseEntity<List<Class>> getAllClasses() {
        return ResponseEntity.ok(classService.getAllClasses());
    }

    // Get a class by class_id
    @GetMapping("/{class_id}")
    public ResponseEntity<Class> getStudentByClassID(@PathVariable String class_id) {
        return classService.getClassByClassID(class_id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new class
    @PostMapping
    public ResponseEntity<Class> addClass(@RequestBody Class class) {
        try {
            return ResponseEntity.ok(classService.addClass(class));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing class
    @PutMapping("/{class_id}")
    public ResponseEntity<Class> updateClass(@PathVariable String class_id, @RequestBody Class updatedClass) {
        try {
            return ResponseEntity.ok(classService.updateClass(class_id, updatedClass));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete a class by class_id
    @DeleteMapping("/{class_id}")
    public ResponseEntity<Void> deleteClass(@PathVariable String class_id) {
        try {
            classService.deleteClass(class_id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}