package com.projectbourne.backend.service;

import com.projectbourne.backend.entity.User;
import com.projectbourne.backend.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthService authService;

    @Test
    void findOrCreateUser_newUser_savesAndReturnsUser() {
        OAuth2User oauth2User = mockOAuth2User("google-123", "new@example.com", "New User");
        when(userRepository.findByGoogleId("google-123")).thenReturn(Optional.empty());
        when(userRepository.save(any(User.class))).thenAnswer(inv -> inv.getArgument(0));

        User result = authService.findOrCreateUser(oauth2User);

        assertThat(result.getGoogleId()).isEqualTo("google-123");
        assertThat(result.getEmail()).isEqualTo("new@example.com");
        assertThat(result.getName()).isEqualTo("New User");
        verify(userRepository).save(any(User.class));
    }

    @Test
    void findOrCreateUser_newUser_populatesAllFields() {
        OAuth2User oauth2User = mockOAuth2User("google-456", "fields@example.com", "Field User");
        when(userRepository.findByGoogleId("google-456")).thenReturn(Optional.empty());
        when(userRepository.save(any(User.class))).thenAnswer(inv -> inv.getArgument(0));

        ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);
        authService.findOrCreateUser(oauth2User);
        verify(userRepository).save(captor.capture());

        User saved = captor.getValue();
        assertThat(saved.getGoogleId()).isEqualTo("google-456");
        assertThat(saved.getEmail()).isEqualTo("fields@example.com");
        assertThat(saved.getName()).isEqualTo("Field User");
    }

    @Test
    void findOrCreateUser_existingUser_returnsExistingWithoutSaving() {
        User existing = existingUser("google-789");
        OAuth2User oauth2User = mockOAuth2User("google-789", "existing@example.com", "Existing User");
        when(userRepository.findByGoogleId("google-789")).thenReturn(Optional.of(existing));

        User result = authService.findOrCreateUser(oauth2User);

        assertThat(result).isSameAs(existing);
        verify(userRepository, never()).save(any());
    }

    @Test
    void findOrCreateUser_existingUser_lookupIsByGoogleId() {
        User existing = existingUser("google-abc");
        OAuth2User oauth2User = mockOAuth2User("google-abc", "any@example.com", "Any User");
        when(userRepository.findByGoogleId("google-abc")).thenReturn(Optional.of(existing));

        authService.findOrCreateUser(oauth2User);

        verify(userRepository).findByGoogleId("google-abc");
        verify(userRepository, never()).save(any());
    }

    private OAuth2User mockOAuth2User(String googleId, String email, String name) {
        OAuth2User oauth2User = mock(OAuth2User.class);
        when(oauth2User.getAttribute("sub")).thenReturn(googleId);
        when(oauth2User.getAttribute("email")).thenReturn(email);
        when(oauth2User.getAttribute("name")).thenReturn(name);
        return oauth2User;
    }

    private User existingUser(String googleId) {
        User user = new User();
        user.setGoogleId(googleId);
        user.setEmail("existing@example.com");
        user.setName("Existing User");
        return user;
    }
}
