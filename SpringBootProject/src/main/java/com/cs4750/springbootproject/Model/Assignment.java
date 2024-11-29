package com.cs4750.springbootproject.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "Assignment")
public class Assignment {
    @Id
    @Column(name = "AssignmentID", nullable = false, unique = true)
    private String assignmentID;

    @Column(name = "title")
    private String assignmentTitle;

    @Column(name = "comments")
    private String comments;

    @Column(name = "due_date")
    private String dueDate;

    @Column(name = "completion_status")
    private String completionStatus;

    @Column(name = "typeID")
    private String typeID;

    public Assignment() {
    }

    public Assignment(String assignmentID, String assignmentTitle, String comments, String dueDate, String completionStatus, String typeID) {
        this.assignmentID = assignmentID;
        this.assignmentTitle = assignmentTitle;
        this.comments = comments;
        this.dueDate = dueDate;
        this.completionStatus = completionStatus;
        this.typeID = typeID;
    }

    public String getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(String assignmentID) {
        this.assignmentID = assignmentID;
    }

    public String getAssignmentTitle() {
        return assignmentTitle;
    }

    public void setAssignmentTitle(String assignmentTitle) {
        this.assignmentTitle = assignmentTitle;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getCompletionStatus() {
        return completionStatus;
    }

    public void setCompletionStatus(String completionStatus) {
        this.completionStatus = completionStatus;
    }

    public String getTypeID() {
        return typeID;
    }

    public void setTypeID(String typeID) {
        this.typeID = typeID;
    }
}
