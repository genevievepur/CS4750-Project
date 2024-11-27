//package com.cs4750.springbootproject.Model;
//
//import jakarta.persistence.*;
//
//
//@Entity
//@Table(name = "Class")
//public class Course {
//
//    @Id
//    @Column(name = "ClassID", nullable = false, unique = true)
//    private String courseID;
//
//    @Column(name = "class_name")
//    private String course_name;
//
//    @Column(name = "location")
//    private String location;
//
//    @Column(name = "meeting_time")
//    private String meeting_time;
//
//    public Course() {
//    }
//
//    public Course(String CourseID, String course_name, String location, String meeting_time) {
//        this.course_id = CourseID;
//        this.course_name = course_name;
//        this.location = location;
//        this.meeting_time = meeting_time;
//    }
//
//    public String getCourseID() {
//        return course_id;
//    }
//
//    public void setCourseID(String course_id) {
//        this.course_id = course_id;
//    }
//
//    public String getCourseName() {
//        return course_name;
//    }
//
//    public void setCourseName(String course_name) {
//        this.course_name = course_name;
//    }
//
//    public String getLocation() {
//        return location;
//    }
//
//    public void setLocation(String location) {
//        this.location = location;
//    }
//
//    public String getMeetingTime() {
//        return meeting_time;
//    }
//
//    public void setMeetingTime(String meeting_time) {
//        this.meeting_time = meeting_time;
//    }
//}

package com.cs4750.springbootproject.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "Class") // Ensure "Class" is not a reserved word in your DB, or rename it.
public class Course {

    @Id
    @Column(name = "ClassID", nullable = false, unique = true)
    private String courseID;

    @Column(name = "class_name")
    private String courseName;

    @Column(name = "location")
    private String location;

    @Column(name = "meeting_time")
    private String meetingTime;

    public Course() {
    }

    public Course(String courseID, String courseName, String location, String meetingTime) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.location = location;
        this.meetingTime = meetingTime;
    }

    public String getCourseID() {
        return courseID;
    }

    public void setCourseID(String courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getMeetingTime() {
        return meetingTime;
    }

    public void setMeetingTime(String meetingTime) {
        this.meetingTime = meetingTime;
    }
}