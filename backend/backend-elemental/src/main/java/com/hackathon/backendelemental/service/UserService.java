package com.hackathon.backendelemental.service;

import com.hackathon.backendelemental.entity.User;
import com.hackathon.backendelemental.entity.UserInput;
import com.hackathon.backendelemental.repository.UserInputRepository;
import com.hackathon.backendelemental.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserInputRepository userInputRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }
    public User loginUser(String email, String password) throws Exception {

        User user = userRepository.findByEmail(email);

        if (user == null || !user.getPassword().equals(password)) {
            throw new Exception("Invalid email or password");
        }

        return user;
    }
    public User getLoggedInUser(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            throw new RuntimeException("No user is currently logged in.");
        }
        return loggedInUser;
    }
    public User findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public User registerUser(String email, String password) {
        if (userRepository.findByEmail(email) != null) {
            throw new IllegalArgumentException("User already exists");
        }

        User newUser = new User(email, password);

        return userRepository.save(newUser);
    }
    @Autowired
    private SequenceGeneratorService sequenceGeneratorService;

    public UserInput saveUserInput(String userId, String transcription, String role) {
        UserInput userInput = new UserInput(userId, transcription, role);
        userInput.setIncrementalId(sequenceGeneratorService.getNextSequence("userInput"));
        return userInputRepository.save(userInput);
    }

    public UserInput getLatestTranscription(String userId) {
        return userInputRepository.findTopByUserIdOrderByIncrementalIdDesc(userId);
    }

}
