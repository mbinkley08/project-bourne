package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SubDomainResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.web.server.ResponseStatusException;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@SpringBootTest
@ActiveProfiles("test")
@Testcontainers
class DomainServiceIT {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
            .withDatabaseName("projectbourne_test")
            .withUsername("postgres")
            .withPassword("postgres");

    @DynamicPropertySource
    static void configureDataSource(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    private DomainService domainService;

    @Test
    void findAllDomains_seedDataPresent_returnsAllSixDomains() {
        List<DomainResponse> domains = domainService.findAllDomains();

        assertThat(domains).hasSize(6);
        assertThat(domains).extracting(DomainResponse::name)
                .containsExactlyInAnyOrder(
                        "Data & Analytics",
                        "Education",
                        "Finance",
                        "Healthcare",
                        "Marketing",
                        "Software Engineering"
                );
    }

    @Test
    void findAllDomains_returnedInAlphabeticalOrder() {
        List<DomainResponse> domains = domainService.findAllDomains();

        assertThat(domains).extracting(DomainResponse::name)
                .isSortedAccordingTo(String::compareTo);
    }

    @Test
    void findSubDomainsByDomainId_softwareEngineering_returnsExpectedSubDomains() {
        UUID softwareEngineeringId = domainService.findAllDomains().stream()
                .filter(d -> d.name().equals("Software Engineering"))
                .findFirst()
                .orElseThrow()
                .id();

        List<SubDomainResponse> subDomains = domainService.findSubDomainsByDomainId(softwareEngineeringId);

        assertThat(subDomains).hasSize(7);
        assertThat(subDomains).extracting(SubDomainResponse::name)
                .containsExactlyInAnyOrder("Backend", "DevOps", "Frontend", "Full Stack", "Mobile", "QA & Testing", "Security");
    }

    @Test
    void findSubDomainsByDomainId_subDomainsReturnedInAlphabeticalOrder() {
        UUID educationId = domainService.findAllDomains().stream()
                .filter(d -> d.name().equals("Education"))
                .findFirst()
                .orElseThrow()
                .id();

        List<SubDomainResponse> subDomains = domainService.findSubDomainsByDomainId(educationId);

        assertThat(subDomains).extracting(SubDomainResponse::name)
                .isSortedAccordingTo(String::compareTo);
    }

    @Test
    void findSubDomainsByDomainId_unknownId_throws404() {
        UUID unknownId = UUID.randomUUID();

        assertThatThrownBy(() -> domainService.findSubDomainsByDomainId(unknownId))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }
}
