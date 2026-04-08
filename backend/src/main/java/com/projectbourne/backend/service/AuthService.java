package com.projectbourne.backend.service;

import com.projectbourne.backend.entity.User;
import com.projectbourne.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;

    public User findOrCreateUser(OAuth2User oauth2User) {
        String googleId = oauth2User.getAttribute("sub");
        String email    = oauth2User.getAttribute("email");
        String name     = oauth2User.getAttribute("name");

        return userRepository.findByGoogleId(googleId)
                .orElseGet(() -> {
                    User user = new User();
                    user.setGoogleId(googleId);
                    user.setEmail(email);
                    user.setName(name);
                    return userRepository.save(user);
                });
    }
}
