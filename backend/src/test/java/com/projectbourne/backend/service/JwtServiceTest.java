package com.projectbourne.backend.service;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.projectbourne.backend.config.JwtConfig;
import com.projectbourne.backend.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.test.util.ReflectionTestUtils;

import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.time.Instant;
import java.util.Base64;
import java.util.Date;
import java.util.UUID;
import java.security.KeyFactory;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import static org.assertj.core.api.Assertions.*;

class JwtServiceTest {

    // Test key pair — matches application-test.yml, safe to commit (test-only, never production)
    private static final String TEST_PRIVATE_KEY =
            "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4BEOn5fuHXXbQ" +
            "0U68eCiwP40fCbu6SdItkMT+oLJ0x8T2t3+W+GWL6RJbxb4m5PIhVrc92akEE3SX" +
            "MC3zBrGlAOeyu8QB7iMEer7WcNFE3bqSW3BrjyrTj1WgNY+tcUyCTgXWEoIW8mDu" +
            "LsV7+9Cfmlxgm8VN8SgIIWM7MnJS8LtSLzQdjiqMeyrXh2tvF+I5m/7gtvV8TXCR" +
            "S/InzUQociI+yLSHFXwCZ+SKbIm0JqHgku/+AnXjFNRAEjQILGEDWLTrcX2MeFxZ" +
            "x+WUlgS+V5DYRdjAjRYbJJ8o1giZbQUYzZaRMSBznC+cA5cYobannb0xl9qJKsnT" +
            "MDT8pfqJAgMBAAECggEAE+cQKzluZERpXKn6vlsvqWpiOMxsc7hWxWteRxz52DQgG" +
            "0AbCmjY0NJXVDo1uA60moL+xC+FvoVdK5oAKkQb1BkeNkBlMYFAY9Rjzh07IRvr" +
            "OTevF88PBn0++Vo5rTxvFjvamT38uH8kGTbRULjaZlzDZ4aJh0XROtnjmew5nbsx" +
            "PlMPrppsN0rBNZCCiAGDr20QLTQheJ8sJmg2c/bvyTWhCka3eGmr+fLTwbFL9MfI" +
            "0e7uqPph3tBtaVQkXKbHV73y1tMJodkqxkpmuXLNNgZc0JtF4Ua1Ng7nCXMyJ1gi" +
            "8la7w0nVklEbdjo+vMKrx4kr+ePXgbzFGucuhcfEwQKBgQDlNCVdkuDkEJssW9ug" +
            "am6X6Tlqi+/3TfAHQQ6QPPSAaasbdpQ1vb0Pn9YkqWP094vzRJkiRf8UjNh3+77w" +
            "RwJyi6ZFReaJJkhdWFC15OsZWqseSOGrjjO/ptqBHDPe3PMv1k6bi59L64gHuTv5t" +
            "fRvW/dJ2wn/0OXOcYU8Gnwg4QKBgQDNh7ZRvvEuHaYsEXIYFuOlor93YiygV6Py" +
            "ApFpYxJ8t7X2Llv2FRWz74vvu29KMwd/C6fe7m37fcpML5xZBn4b/b2OlErzESZ7" +
            "7tB0qhPnO7VfvFf6lANGAwZ6PbTy3Ynr2eyiaPwZDnE3igRWFUGbHQ/rDT63+3Zn" +
            "TJoQQs8GqQKBgQCW1RIh2h6U9zimoGyPzHqrDZfzPdPU8z0aCP4EfZiJSQCJOiee" +
            "lhZsycqqpa5Z7u3yURpVK6sJYwaxLsIgbRp3Nt9chvuHFeJZS10R1mvAa6Jgc6XO" +
            "t+3mGW+Bt4WLC+wddvKT+fYCiCUksAl/8vXAssyxlaum5VnV2W7MdsFpAQKBgQCu" +
            "WEXvOALMtLfmP/JBvwDi25iBQ9VJOq7Gtyj0decTxp7jMtYtfBtJ5JUXCi9QiNL+" +
            "ETwYnrbLFByL3gNJfXlycx7eGKsvX0f+70kC/dceWobzrAgRdocEV8Kh5UBemFDL" +
            "sbPK3TWkZ5zgmQIup59cXh3HrReb6AK7g75YtuN46QKBgGB7UnYEsI3Yg3aY2Rzr" +
            "mbrNoyxtV+r3KzmS53GTcJLW3spyZK/+lxAspHBtyQXJDOjJDawvxFsadN6W28kd" +
            "E+AquOgQEskAhBp4FTHLOaCyqAuqZdsLSWsftZrr75X9dlGou86xUvy9OBEhNrI8" +
            "ioIdkYhuHlvn0rI4AS3ctOTQ";

    private static final String TEST_PUBLIC_KEY =
            "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuARDp+X7h1120NFOvHgo" +
            "sD+NHwm7uknSLZDE/qCydMfE9rd/lvhli+kSW8W+JuTyIVa3PdmpBBN0lzAt8wax" +
            "pQDnsrvEAe4jBHq+1nDRRN26kltwa48q049VoDWPrXFMgk4F1hKCFvJg7i7Fe/vQ" +
            "n5pcYJvFTfEoCCFjOzJyUvC7Ui80HY4qjHsq14drbxfiOZv+4Lb1fE1wkUvyJ81E" +
            "KHIiPsi0hxV8AmfkimyJtCah4JLv/gJ14xTUQBI0CCxhA1i063F9jHhcWcfllJYE" +
            "vleQ2EXYwI0WGySfKNYImW0FGM2WkTEgc5wvnAOXGKG2p529MZfaiSrJ0zA0/KX6" +
            "iQIDAQAB";

    private JwtService jwtService;

    @BeforeEach
    void setUp() throws Exception {
        JwtConfig config = new JwtConfig();
        ReflectionTestUtils.setField(config, "privateKeyBase64", TEST_PRIVATE_KEY);
        ReflectionTestUtils.setField(config, "publicKeyBase64", TEST_PUBLIC_KEY);

        jwtService = new JwtService(config.jwtEncoder(), config.jwtDecoder());
        ReflectionTestUtils.setField(jwtService, "expirationSeconds", 86400L);
    }

    @Test
    void generateToken_returnsNonEmptyToken() {
        String token = jwtService.generateToken(testUser());
        assertThat(token).isNotBlank();
    }

    @Test
    void generateToken_containsCorrectClaims() {
        User user = testUser();
        String token = jwtService.generateToken(user);
        Jwt jwt = jwtService.validateToken(token);

        assertThat(jwt.getSubject()).isEqualTo(user.getId().toString());
        assertThat(jwt.<String>getClaim("email")).isEqualTo(user.getEmail());
        assertThat(jwt.<String>getClaim("name")).isEqualTo(user.getName());
        assertThat(jwt.getIssuer().toString()).isEqualTo("https://projectbourne.app");
    }

    @Test
    void generateToken_expiryIsSet() {
        Jwt jwt = jwtService.validateToken(jwtService.generateToken(testUser()));
        assertThat(jwt.getExpiresAt()).isNotNull();
        assertThat(jwt.getExpiresAt()).isAfter(jwt.getIssuedAt());
    }

    @Test
    void validateToken_validToken_succeeds() {
        String token = jwtService.generateToken(testUser());
        assertThatNoException().isThrownBy(() -> jwtService.validateToken(token));
    }

    @Test
    void validateToken_garbageString_throwsJwtException() {
        assertThatThrownBy(() -> jwtService.validateToken("not.a.valid.jwt"))
                .isInstanceOf(JwtException.class);
    }

    @Test
    void validateToken_expiredToken_throwsJwtException() throws Exception {
        // Spring's encoder rejects expiresAt < issuedAt at encode time, so we build
        // the expired token directly with Nimbus to bypass that validation.
        RSAPrivateKey privateKey = parsePrivateKey(TEST_PRIVATE_KEY);
        RSAPublicKey publicKey = parsePublicKey(TEST_PUBLIC_KEY);
        RSAKey rsaKey = new RSAKey.Builder(publicKey).privateKey(privateKey).build();

        JWTClaimsSet claims = new JWTClaimsSet.Builder()
                .issuer("https://projectbourne.app")
                .subject(UUID.randomUUID().toString())
                .issueTime(Date.from(Instant.now().minusSeconds(7200)))
                .expirationTime(Date.from(Instant.now().minusSeconds(3600)))
                .build();

        SignedJWT signedJWT = new SignedJWT(new JWSHeader.Builder(JWSAlgorithm.RS256).build(), claims);
        signedJWT.sign(new RSASSASigner(rsaKey));
        String expiredToken = signedJWT.serialize();

        assertThatThrownBy(() -> jwtService.validateToken(expiredToken))
                .isInstanceOf(JwtException.class);
    }

    private RSAPrivateKey parsePrivateKey(String base64Der) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(base64Der.replaceAll("\\s", ""));
        return (RSAPrivateKey) KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(keyBytes));
    }

    private RSAPublicKey parsePublicKey(String base64Der) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(base64Der.replaceAll("\\s", ""));
        return (RSAPublicKey) KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(keyBytes));
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
