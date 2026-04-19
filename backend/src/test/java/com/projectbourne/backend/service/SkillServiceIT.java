package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SkillResponse;
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
class SkillServiceIT {

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
    private SkillService skillService;

    @Autowired
    private DomainService domainService;

    @Test
    void findSkills_noParams_seedDataPresent_returnsAllSkills() {
        List<SkillResponse> skills = skillService.findSkills(null, null);

        assertThat(skills).isNotEmpty();
        assertThat(skills).extracting(SkillResponse::curated).containsOnly(true);
    }

    @Test
    void findSkills_noParams_returnedInAlphabeticalOrder() {
        List<SkillResponse> skills = skillService.findSkills(null, null);

        assertThat(skills).extracting(SkillResponse::name)
                .isSortedAccordingTo(String::compareTo);
    }

    @Test
    void findSkills_bySubDomainId_backendSubDomain_containsExpectedSkills() {
        UUID backendId = getSubDomainId("Software Engineering", "Backend");

        List<SkillResponse> skills = skillService.findSkills(null, backendId);

        assertThat(skills).extracting(SkillResponse::name)
                .contains("Java", "Spring Boot", "Git", "Docker", "PostgreSQL");
    }

    @Test
    void findSkills_bySubDomainId_returnedInAlphabeticalOrder() {
        UUID backendId = getSubDomainId("Software Engineering", "Backend");

        List<SkillResponse> skills = skillService.findSkills(null, backendId);

        assertThat(skills).extracting(SkillResponse::name)
                .isSortedAccordingTo(String::compareTo);
    }

    @Test
    void findSkills_byDomainId_softwareEngineering_containsSkillsAcrossSubDomains() {
        UUID softwareEngineeringId = getDomainId("Software Engineering");

        List<SkillResponse> skills = skillService.findSkills(softwareEngineeringId, null);

        assertThat(skills).extracting(SkillResponse::name)
                .contains("Java", "React", "Kubernetes", "Selenium", "OWASP");
    }

    @Test
    void findSkills_byDomainId_noDuplicates() {
        UUID softwareEngineeringId = getDomainId("Software Engineering");

        List<SkillResponse> skills = skillService.findSkills(softwareEngineeringId, null);
        long distinctCount = skills.stream().map(SkillResponse::name).distinct().count();

        assertThat(skills).hasSize((int) distinctCount);
    }

    @Test
    void findSkills_crossDomainSkill_returnedForEachSubDomain() {
        UUID backendId = getSubDomainId("Software Engineering", "Backend");
        UUID devOpsId = getSubDomainId("Software Engineering", "DevOps");

        List<String> backendSkills = skillService.findSkills(null, backendId).stream()
                .map(SkillResponse::name).toList();
        List<String> devOpsSkills = skillService.findSkills(null, devOpsId).stream()
                .map(SkillResponse::name).toList();

        assertThat(backendSkills).contains("Docker");
        assertThat(devOpsSkills).contains("Docker");
    }

    @Test
    void findSkills_bySubDomainId_unknownId_throws404() {
        assertThatThrownBy(() -> skillService.findSkills(null, UUID.randomUUID()))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    void findSkills_byDomainId_unknownId_throws404() {
        assertThatThrownBy(() -> skillService.findSkills(UUID.randomUUID(), null))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    private UUID getDomainId(String domainName) {
        return domainService.findAllDomains().stream()
                .filter(d -> d.name().equals(domainName))
                .findFirst()
                .orElseThrow()
                .id();
    }

    private UUID getSubDomainId(String domainName, String subDomainName) {
        UUID domainId = getDomainId(domainName);
        return domainService.findSubDomainsByDomainId(domainId).stream()
                .filter(sd -> sd.name().equals(subDomainName))
                .findFirst()
                .orElseThrow()
                .id();
    }
}
