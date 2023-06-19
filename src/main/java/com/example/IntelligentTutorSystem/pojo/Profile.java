package com.example.IntelligentTutorSystem.pojo;

import jakarta.persistence.*;


@Entity
public class Profile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String email;
    private int age;

    @Enumerated(EnumType.STRING)
    private Subject preferredSubject;

    @Enumerated(EnumType.STRING)
    private DifficultyLevel difficultyLevel;

    @Enumerated(EnumType.STRING)
    private LearningStyle learningStyle;

    private int completedCourses;
    private double averageScore;

    @OneToOne
    private User user;

    private String profilePictureUrl;

    public Profile() {

    }

    public Profile(Long id, String name, String email, int age, Subject preferredSubject, DifficultyLevel difficultyLevel, LearningStyle learningStyle, int completedCourses, double averageScore, User user, String profilePictureUrl) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.age = age;
        this.preferredSubject = preferredSubject;
        this.difficultyLevel = difficultyLevel;
        this.learningStyle = learningStyle;
        this.completedCourses = completedCourses;
        this.averageScore = averageScore;
        this.user = user;
        this.profilePictureUrl = profilePictureUrl;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Subject getPreferredSubject() {
        return preferredSubject;
    }

    public void setPreferredSubject(Subject preferredSubject) {
        this.preferredSubject = preferredSubject;
    }

    public DifficultyLevel getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(DifficultyLevel difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public LearningStyle getLearningStyle() {
        return learningStyle;
    }

    public void setLearningStyle(LearningStyle learningStyle) {
        this.learningStyle = learningStyle;
    }

    public int getCompletedCourses() {
        return completedCourses;
    }

    public void setCompletedCourses(int completedCourses) {
        this.completedCourses = completedCourses;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getProfilePictureUrl() {
        return profilePictureUrl;
    }

    public void setProfilePictureUrl(String profilePictureUrl) {
        this.profilePictureUrl = profilePictureUrl;
    }
}
