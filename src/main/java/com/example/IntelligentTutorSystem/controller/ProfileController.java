package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.pojo.*;
import com.example.IntelligentTutorSystem.service.ProfileService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/profile")
public class ProfileController {
    @Autowired
    private ProfileService profileService;

    @PostMapping
    public Profile createProfile(@RequestBody Profile profile) {
        return profileService.createProfile(profile);
    }

    @PutMapping
    public Profile updateProfile(@RequestBody Profile profile) {
        return profileService.updateProfile(profile);
    }

    @GetMapping("/{id}")
    public Profile getProfile(@PathVariable Long id) {
        return profileService.getProfile(id);
    }

    @PutMapping("/{id}/subject")
    public Profile updatePreferredSubject(@PathVariable Long id, @RequestBody Subject newSubject) {
        return profileService.updatePreferredSubject(id, newSubject);
    }

    @PutMapping("/{id}/level")
    public Profile updateDifficultyLevel(@PathVariable Long id, @RequestBody DifficultyLevel newLevel) {
        return profileService.updateDifficultyLevel(id, newLevel);
    }

    @PutMapping("/{id}/style")
    public Profile updateLearningStyle(@PathVariable Long id, @RequestBody LearningStyle newStyle) {
        return profileService.updateLearningStyle(id, newStyle);
    }


}
