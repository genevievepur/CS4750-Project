package com.cs4750.springbootproject.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "Advisor")
public class Advisor {

    @Id
    @Column(name = "AdvisorID", nullable = false, unique = true)
    private String advisorID;

    @Column(name = "advisor_name", nullable = false)
    private String advisorName;

    @Column(name = "department", nullable = false)
    private String department;

    @Column(name = "advisor_email", nullable = false, unique = true)
    private String advisorEmail;

    public Advisor() {
    }

    public Advisor(String advisorID, String advisorName, String department, String advisorEmail) {
        this.advisorID = advisorID;
        this.advisorName = advisorName;
        this.department = department;
        this.advisorEmail = advisorEmail;
    }

    public String getAdvisorID() {
        return advisorID;
    }

    public void setAdvisorID(String advisorID) {
        this.advisorID = advisorID;
    }

    public String getAdvisorName() {
        return advisorName;
    }

    public void setAdvisorName(String advisorName) {
        this.advisorName = advisorName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getAdvisorEmail() {
        return advisorEmail;
    }

    public void setAdvisorEmail(String advisorEmail) {
        this.advisorEmail = advisorEmail;
    }
}
