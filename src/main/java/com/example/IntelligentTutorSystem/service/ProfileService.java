package com.example.IntelligentTutorSystem.service;

import com.example.IntelligentTutorSystem.pojo.*;
import com.example.IntelligentTutorSystem.repository.ProfileRepository;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;


@Service
public class ProfileService {
    @Autowired
    private ProfileRepository profileRepository;



    public Profile createProfile(Profile profile) {
        return profileRepository.save(profile);
    }

    public Profile updateProfile(Profile profile) {
        return profileRepository.save(profile);
    }

    public Profile getProfile(Long id) {
        return profileRepository.findById(id).orElse(null);
    }



    public Profile updatePreferredSubject(Long id, Subject newSubject) {
        Profile profile = getProfile(id);
        if (profile != null) {
            profile.setPreferredSubject(newSubject);
            profileRepository.save(profile);
        }
        return profile;
    }

    public Profile updateDifficultyLevel(Long id, DifficultyLevel newLevel) {
        Profile profile = getProfile(id);
        if (profile != null) {
            profile.setDifficultyLevel(newLevel);
            profileRepository.save(profile);
        }
        return profile;
    }

    public Profile updateLearningStyle(Long id, LearningStyle newStyle) {
        Profile profile = getProfile(id);
        if (profile != null) {
            profile.setLearningStyle(newStyle);
            profileRepository.save(profile);
        }
        return profile;
    }


}
