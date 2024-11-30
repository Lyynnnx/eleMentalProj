package com.hackathon.backendelemental.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document
@Getter
@Setter
@NoArgsConstructor
public class AiInput {
    @Id
    private String id;
    private String transcriptText;
    private String audioFilePath;
    private LocalDateTime updatedAt;

    public AiInput(String transcriptText, String audioFilePath) {
        this.transcriptText = transcriptText;
        this.audioFilePath = audioFilePath;
        this.updatedAt = LocalDateTime.now();
    }
}
