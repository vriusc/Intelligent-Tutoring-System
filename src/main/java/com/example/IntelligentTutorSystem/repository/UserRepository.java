package com.example.IntelligentTutorSystem.repository;

import com.example.IntelligentTutorSystem.mode.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByUsername(String username);
    User findByEmail(String email);

}
