package com.cs4750.springbootproject.Controller;

import com.cs4750.springbootproject.Model.Advisor;
import com.cs4750.springbootproject.Service.AdvisorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/advisors")
public class AdvisorController {
    private final AdvisorService advisorService;

    public AdvisorController(AdvisorService advisorService) {
        this.advisorService = advisorService;
    }

    // Get all advisors
    @GetMapping
    public ResponseEntity<List<Advisor>> getAllAdvisors() {
        return ResponseEntity.ok(advisorService.getAllAdvisors());
    }

    // Get an advisor by AdvisorID
    @GetMapping("/{advisorID}")
    public ResponseEntity<Advisor> getAdvisorByAdvisorID(@PathVariable String advisorID) {
        return advisorService.getAdvisorByAdvisorID(advisorID)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Add a new advisor
    @PostMapping
    public ResponseEntity<Advisor> addAdvisor(@RequestBody Advisor advisor) {
        try {
            return ResponseEntity.ok(advisorService.addAdvisor(advisor));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Update an existing advisor
    @PutMapping("/{advisorID}")
    public ResponseEntity<Advisor> updateAdvisor(@PathVariable String advisorID, @RequestBody Advisor updatedAdvisor) {
        try {
            return ResponseEntity.ok(advisorService.updateAdvisor(advisorID, updatedAdvisor));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Delete an advisor by AdvisorID
    @DeleteMapping("/{advisorID}")
    public ResponseEntity<Void> deleteAdvisor(@PathVariable String advisorID) {
        try {
            advisorService.deleteAdvisor(advisorID);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
