package com.cs4750.springbootproject.Repository;

import com.cs4750.springbootproject.Model.Class;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ClassRepository extends JpaRepository<Class, String> {
    Optional<Class> findByClassID(String class_id);

    boolean existsByID(String class_id);

    boolean existsByName(String className);
}