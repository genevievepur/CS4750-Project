package com.cs4750.springbootproject.Service;

import com.cs4750.springbootproject.Model.Advisor;
import com.cs4750.springbootproject.Repository.AdvisorRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdvisorService {
    private final AdvisorRepository repository;

    public AdvisorService(AdvisorRepository repository) {
        this.repository = repository;
    }

    // Get all advisors
    public List<Advisor> getAllAdvisors() {
        return repository.findAll();
    }

    // Get an advisor by AdvisorID
    public Optional<Advisor> getAdvisorByAdvisorID(String advisorID) {
        return repository.findByAdvisorID(advisorID);
    }

    // Add a new advisor
    public Advisor addAdvisor(Advisor advisor) {
        if (repository.existsByAdvisorID(advisor.getAdvisorID())) {
            throw new RuntimeException("AdvisorID already in use!");
        }
        if (repository.existsByAdvisorEmail(advisor.getAdvisorEmail())) {
            throw new RuntimeException("Advisor email already in use!");
        }
        return repository.save(advisor);
    }

    // Update an existing advisor
    public Advisor updateAdvisor(String advisorID, Advisor updatedAdvisor) {
        return repository.findByAdvisorID(advisorID).map(advisor -> {
            advisor.setAdvisorID(updatedAdvisor.getAdvisorID());
            advisor.setAdvisorName(updatedAdvisor.getAdvisorName());
            advisor.setDepartment(updatedAdvisor.getDepartment());
            advisor.setAdvisorEmail(updatedAdvisor.getAdvisorEmail());
            return repository.save(advisor);
        }).orElseThrow(() -> new RuntimeException("Advisor not found with AdvisorID: " + advisorID));
    }

    // Delete an advisor by AdvisorID
    public void deleteAdvisor(String advisorID) {
        Advisor advisor = repository.findByAdvisorID(advisorID)
                .orElseThrow(() -> new RuntimeException("Advisor not found with AdvisorID: " + advisorID));
        repository.delete(advisor);
    }
}
