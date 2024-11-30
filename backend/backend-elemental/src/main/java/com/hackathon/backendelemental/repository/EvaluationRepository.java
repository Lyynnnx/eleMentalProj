package com.hackathon.backendelemental.repository;

import com.hackathon.backendelemental.entity.Evaluation;
import org.springframework.data.mongodb.repository.MongoRepository;

import org.springframework.data.mongodb.repository.MongoRepository;
import com.hackathon.backendelemental.entity.Evaluation;

public interface EvaluationRepository extends MongoRepository<Evaluation, String> {
    Evaluation  findFirstByOrderByUpdatedAtDesc();
}