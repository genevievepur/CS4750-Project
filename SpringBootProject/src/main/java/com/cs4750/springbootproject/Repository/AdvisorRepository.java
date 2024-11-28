package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Advisor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdvisorRepository extends JpaRepository<Advisor, String> {
    Optional<Advisor> findByAdvisorID(String advisorID);

    boolean existsByAdvisorID(String advisorID);

    boolean existsByAdvisorEmail(String advisorEmail);

    boolean existsByAdvisorName(String advisorName);
}
