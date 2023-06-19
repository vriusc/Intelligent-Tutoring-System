package com.example.IntelligentTutorSystem.repository;
import com.example.IntelligentTutorSystem.pojo.Profile;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ProfileRepository extends JpaRepository<Profile, Long> {

    Profile findByName(String name);

    Profile findByEmail(String email);

}
