package com.hackathon.backendelemental.repository;

import com.hackathon.backendelemental.entity.AiInput;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface AiInputRepository extends MongoRepository<AiInput, String> {
    AiInput findFirstByOrderByUpdatedAtDesc(); // fetch the most recently updated record
}
