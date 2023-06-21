package com.example.IntelligentTutorSystem.service;
import com.example.IntelligentTutorSystem.pojo.Questions.Question;
import com.example.IntelligentTutorSystem.pojo.Questions.Score;
import com.example.IntelligentTutorSystem.pojo.Users.User;
import com.example.IntelligentTutorSystem.repository.QuestionRepository;
import com.example.IntelligentTutorSystem.repository.ScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class TestService {


    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ScoreRepository scoreRepository;

    //随机生成 5 个题目
    public List<Question> getRandomQuestions() {
        List<Question> allQuestions = questionRepository.findAll();
        if (allQuestions.isEmpty()) {
            return allQuestions;
        }
        Collections.shuffle(allQuestions);
        return allQuestions.subList(0, 5);
    }


    // 保存分数
    public void saveScore(User user, int score,Long test_id) {
        Score scoreRecord = new Score();
        scoreRecord.setUser(user);
        scoreRecord.setScore(score);
        scoreRecord.setTest_id(test_id);
        scoreRepository.save(scoreRecord);
    }


}
