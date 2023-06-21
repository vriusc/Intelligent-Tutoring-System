package com.example.IntelligentTutorSystem.pojo.Questions;

import jakarta.persistence.*;

import java.util.List;


@Entity
public class Question {

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        private Long id;
        private String text;
        @OneToMany(cascade = CascadeType.ALL, mappedBy = "question")
        private List<Option> options;

        public Question() {
        }


        public Question(Long id, String text, List<Option> options) {
                this.id = id;
                this.text = text;
                this.options = options;
        }


        public Long getId() {
                return id;
        }

        public void setId(Long id) {
                this.id = id;
        }

        public String getText() {
                return text;
        }

        public void setText(String text) {
                this.text = text;
        }

        public List<Option> getOptions() {
                return options;
        }

        public void setOptions(List<Option> options) {
                this.options = options;
        }
}


