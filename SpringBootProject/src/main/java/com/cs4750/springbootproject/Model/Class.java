package com.cs4750.springbootproject.Model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;


@Entity
@Table(name = "Class")
public class Class {

    @Id
    @Column(name = "ClassID", nullable = false, unique = true)
    private String classID;

    @Column(name = "class_name")
    private String class_name;

    @Column(name = "location")
    private String location;

    @Column(name = "meeting_time")
    private String meeting_time;

    public Class() {
    }

    public Class(String ClassID, String class_name, String location, String meeting_time) {
        this.ClassID = ClassID;
        this.class_name = class_name;
        this.location = location;
        this.meeting_time = meeting_time;
    }

    public String getClassID() {
        return ClassID;
    }

    public void setClassID(String ClassID) {
        this.ClassID = ClassID;
    }

    public String getClassName() {
        return class_name;
    }

    public void setClassName(String class_name) {
        this.class_name = class_name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getMeetingTime() {
        return meeting_time;
    }

    public void setMeetingTime(String meeting_time) {
        this.meeting_time = meeting_time;
    }
}