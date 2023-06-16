package com.example.IntelligentTutorSystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.IntelligentTutorSystem.mode.User;
import com.example.IntelligentTutorSystem.repository.UserRepository;

@SpringBootApplication
public class IntelligentTutorSystemApplication implements CommandLineRunner {

	@Autowired
	private UserRepository userRepository;     

	public static void main(String[] args) {
		SpringApplication.run(IntelligentTutorSystemApplication.class, args);
	}

	@Override
	public void run(String...args) throws Exception {

		this.userRepository.save(new User("Ramesh","123","ramesh@gmail.com"));
		this.userRepository.save(new User("Tom", "123", "tom@gmail.com"));
		this.userRepository.save(new User("Tony", "123", "tony@gmail.com"));
	}
}
