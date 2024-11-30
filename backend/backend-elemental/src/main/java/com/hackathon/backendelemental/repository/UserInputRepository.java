package com.hackathon.backendelemental.repository;

import com.hackathon.backendelemental.entity.UserInput;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserInputRepository extends MongoRepository<UserInput, String> {
    UserInput findTopByUserIdOrderByIncrementalIdDesc(String userId);
}
