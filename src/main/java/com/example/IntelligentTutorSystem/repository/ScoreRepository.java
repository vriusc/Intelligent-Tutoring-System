package com.example.IntelligentTutorSystem.repository;

import com.example.IntelligentTutorSystem.pojo.Questions.Score;
import com.example.IntelligentTutorSystem.pojo.Users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScoreRepository extends JpaRepository<Score, Long> {

    // 查询用户所有test的得分情况
    List<Score> findByUser(User user);

}
