package com.example.IntelligentTutorSystem.repository;

import com.example.IntelligentTutorSystem.pojo.Questions.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {
}

