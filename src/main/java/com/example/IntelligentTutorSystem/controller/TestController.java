package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.pojo.Questions.Option;
import com.example.IntelligentTutorSystem.pojo.Questions.Question;
import com.example.IntelligentTutorSystem.pojo.Users.User;
import com.example.IntelligentTutorSystem.repository.OptionRepository;
import com.example.IntelligentTutorSystem.service.TestService;
import com.example.IntelligentTutorSystem.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;



import java.util.List;
import java.util.Map;

@RestController
public class TestController {

    @Resource
    private TestService testService;
    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private UserService userService;


    // 跳转到test页面
    @GetMapping("/test")
    public List<Question> getTestPage() {
        List<Question> questions = testService.getRandomQuestions();
         return questions;
    }

    // 提交测试
    @PostMapping("/test")
    public String submitTest(@RequestBody User user, @RequestParam  Map<String, String> allRequestParams) {

        int score = 0;


        Long testId = Long.parseLong(allRequestParams.get("testId"));

        for (String key : allRequestParams.keySet()) {
            if (key.equals("testId")) continue; // 跳过testId字段
            Long optionId = Long.parseLong(allRequestParams.get(key));
            Option selectedOption = optionRepository.findById(optionId).get();
            if (selectedOption.isCorrect()) {
                score++;
            }
        }
        user = userService.findUserByUsernameOrEmail(user.getUsername(), user.getEmail());

        // 保存测试的id和分数
        testService.saveScore(user, score, testId);

        return "score";
    }


}
