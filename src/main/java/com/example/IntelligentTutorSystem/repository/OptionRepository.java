package com.example.IntelligentTutorSystem.repository;

import com.example.IntelligentTutorSystem.pojo.Questions.Option;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OptionRepository extends JpaRepository<Option, Long> {

}
