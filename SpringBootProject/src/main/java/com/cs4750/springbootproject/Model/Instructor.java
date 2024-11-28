package com.cs4750.springbootproject.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "Instructor")
public class Instructor {

    @Id
    @Column(name = "InstructorID", nullable = false, unique = true, length = 10)
    private String id;

    @Column(name = "instructor_email", nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "instructor_name", nullable = false, length = 100)
    private String name;

    // Default constructor
    public Instructor() {
    }

    // Parameterized constructor
    public Instructor(String id, String name, String email) {
        this.id = id;
        this.email = email;
        this.name = name;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
