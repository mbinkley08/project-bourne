package com.projectbourne.backend.controller;

import com.projectbourne.backend.entity.User;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
class AuthControllerTest {

    @InjectMocks
    private AuthController controller;

    @Test
    void me_authenticated_returnsOkWithUserInfo() {
        User user = testUser();
        Authentication auth = new UsernamePasswordAuthenticationToken(user, null, List.of());

        ResponseEntity<Map<String, Object>> response = controller.me(auth);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).containsEntry("id", user.getId());
        assertThat(response.getBody()).containsEntry("email", user.getEmail());
        assertThat(response.getBody()).containsEntry("name", user.getName());
    }

    @Test
    void me_nullAuthentication_returnsUnauthorized() {
        ResponseEntity<Map<String, Object>> response = controller.me(null);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
        assertThat(response.getBody()).isNull();
    }

    @Test
    void me_unauthenticatedPrincipal_returnsUnauthorized() {
        Authentication auth = new UsernamePasswordAuthenticationToken(null, null);

        ResponseEntity<Map<String, Object>> response = controller.me(auth);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
    }

    @Test
    void logout_returnsNoContent() {
        ResponseEntity<Void> response = controller.logout(new MockHttpServletResponse());
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NO_CONTENT);
    }

    @Test
    void logout_setsClearCookieHeader() {
        MockHttpServletResponse response = new MockHttpServletResponse();
        controller.logout(response);

        String setCookieHeader = response.getHeader("Set-Cookie");
        assertThat(setCookieHeader).contains("auth_token=");
        assertThat(setCookieHeader).contains("Max-Age=0");
        assertThat(setCookieHeader).contains("HttpOnly");
        assertThat(setCookieHeader).contains("SameSite=Strict");
    }

    private User testUser() {
        User user = new User();
        ReflectionTestUtils.setField(user, "id", UUID.randomUUID());
        user.setEmail("test@example.com");
        user.setName("Test User");
        user.setGoogleId("google-123");
        return user;
    }
}
