package com.hackathon.backendelemental.repository;

import com.hackathon.backendelemental.entity.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepository extends MongoRepository<User, String> {
    User findByEmail(String email);
}

