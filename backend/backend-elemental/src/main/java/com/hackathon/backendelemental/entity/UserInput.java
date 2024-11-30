package com.hackathon.backendelemental.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Getter
@NoArgsConstructor
@Setter
public class UserInput {
    @Id
    private String id;
    private String userId;  // foreign key to link the transcription to a user
    private String transcription;
    private String role;
    private int incrementalId;

    public UserInput(String userId, String transcription, String role) {
        this.userId = userId;
        this.transcription = transcription;
        this.role = role;
    }

}
