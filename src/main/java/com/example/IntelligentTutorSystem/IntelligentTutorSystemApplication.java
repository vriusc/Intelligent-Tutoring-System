package com.example.IntelligentTutorSystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
@ComponentScan(basePackages = "com.**")
public class IntelligentTutorSystemApplication {



	public static void main(String[] args) {
		SpringApplication.run(IntelligentTutorSystemApplication.class, args);

	}


	public void run(String...args) throws Exception {
//
//		this.userRepository.save(new User("Ramesh","123","ramesh@gmail.com"));
//		this.userRepository.save(new User("Tom", "123", "tom@gmail.com"));
//		this.userRepository.save(new User("Tony", "123", "tony@gmail.com"));
	}
}
