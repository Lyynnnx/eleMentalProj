package com.hackathon.backendelemental.controller;


import com.hackathon.backendelemental.entity.User;
import com.hackathon.backendelemental.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public ResponseEntity<User> registerUser(@RequestBody User user) {
        try {
            User registeredUser = userService.registerUser(user.getEmail(), user.getPassword());
            return ResponseEntity.ok(registeredUser);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(HttpServletRequest request, @RequestBody User user) {
        try {
            User authenticatedUser = userService.loginUser(user.getEmail(), user.getPassword());

            request.getSession().setAttribute("user", authenticatedUser);

            return ResponseEntity.ok("Login successful");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Invalid email or password");
        }
    }


    @GetMapping("/{email}")
    public ResponseEntity<User> getUserByEmail(@PathVariable String email) {
        User user = userService.findUserByEmail(email);
        return user != null ? ResponseEntity.ok(user) : ResponseEntity.notFound().build();
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getUserProfile(HttpServletRequest request) {
        User loggedInUser = (User) request.getSession().getAttribute("user");

        if (loggedInUser == null) {
            return ResponseEntity.status(401).body("You are not logged in.");
        }

        return ResponseEntity.ok(loggedInUser);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logoutUser(HttpServletRequest request) {
        request.getSession().invalidate();
        return ResponseEntity.ok("Logged out successfully");
    }
}

