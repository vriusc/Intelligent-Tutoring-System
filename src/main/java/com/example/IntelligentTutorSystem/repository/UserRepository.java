package com.example.IntelligentTutorSystem.repository;

import com.example.IntelligentTutorSystem.pojo.Users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// 操作数据库
@Repository
public interface UserRepository extends JpaRepository<User, Long> {



    User findByUsername(String username);



    User findByEmail(String email);








}