package com.projectbourne.backend.config;

import com.projectbourne.backend.security.JwtAuthFilter;
import com.projectbourne.backend.security.OAuth2SuccessHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final OAuth2SuccessHandler oauth2SuccessHandler;
    private final JwtAuthFilter jwtAuthFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/health", "/actuator/**", "/auth/logout").permitAll()
                .anyRequest().authenticated()
            )
            .oauth2Login(oauth2 -> oauth2
                .successHandler(oauth2SuccessHandler)
            )
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)
            .sessionManagement(session -> session
                // IF_REQUIRED: sessions exist only for the OAuth2 flow (state param storage).
                // API requests authenticated via JWT cookie are effectively stateless.
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            )
            // CSRF disabled — JWT in httpOnly cookie with SameSite=Strict prevents CSRF.
            // Cross-site requests cannot carry the cookie, so there is no CSRF vector.
            .csrf(csrf -> csrf.disable());

        return http.build();
    }
}
