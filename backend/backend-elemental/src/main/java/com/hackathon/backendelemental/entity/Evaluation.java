package com.hackathon.backendelemental.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document(collection = "evaluations")
public class Evaluation {

    @Id
    private String id; // Unique identifier for the evaluation

    private int aspect1; // Value for aspect 1 (1 to 5)
    private int aspect2; // Value for aspect 2 (1 to 5)
    private int aspect3; // Value for aspect 3 (1 to 5)
    private int aspect4; // Value for aspect 4 (1 to 5)
    private String text;
    @LastModifiedDate
    private LocalDateTime updatedAt;

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }// Additional evaluation text


    public Evaluation() {
    }

    public Evaluation(int aspect1, int aspect2, int aspect3, int aspect4, String text) {
        this.aspect1 = aspect1;
        this.aspect2 = aspect2;
        this.aspect3 = aspect3;
        this.aspect4 = aspect4;
        this.text = text;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getAspect1() {
        return aspect1;
    }

    public void setAspect1(int aspect1) {
        this.aspect1 = aspect1;
    }

    public int getAspect2() {
        return aspect2;
    }

    public void setAspect2(int aspect2) {
        this.aspect2 = aspect2;
    }

    public int getAspect3() {
        return aspect3;
    }

    public void setAspect3(int aspect3) {
        this.aspect3 = aspect3;
    }

    public int getAspect4() {
        return aspect4;
    }

    public void setAspect4(int aspect4) {
        this.aspect4 = aspect4;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
