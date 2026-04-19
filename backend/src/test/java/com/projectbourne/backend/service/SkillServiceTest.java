package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.SkillResponse;
import com.projectbourne.backend.entity.Skill;
import com.projectbourne.backend.repository.DomainRepository;
import com.projectbourne.backend.repository.SkillRepository;
import com.projectbourne.backend.repository.SubDomainRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class SkillServiceTest {

    @Mock
    private SkillRepository skillRepository;

    @Mock
    private DomainRepository domainRepository;

    @Mock
    private SubDomainRepository subDomainRepository;

    @InjectMocks
    private SkillService skillService;

    @Test
    void findSkills_noParams_returnsAllSkills() {
        Skill skill = skill("Java");
        when(skillRepository.findAllByOrderByNameAsc()).thenReturn(List.of(skill));

        List<SkillResponse> result = skillService.findSkills(null, null);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).name()).isEqualTo("Java");
        assertThat(result.get(0).curated()).isTrue();
    }

    @Test
    void findSkills_noParams_emptyRepository_returnsEmptyList() {
        when(skillRepository.findAllByOrderByNameAsc()).thenReturn(List.of());

        List<SkillResponse> result = skillService.findSkills(null, null);

        assertThat(result).isEmpty();
    }

    @Test
    void findSkills_bySubDomainId_returnsSkillsForSubDomain() {
        UUID subDomainId = UUID.randomUUID();
        Skill skill = skill("Spring Boot");
        when(subDomainRepository.existsById(subDomainId)).thenReturn(true);
        when(skillRepository.findBySubDomainId(subDomainId)).thenReturn(List.of(skill));

        List<SkillResponse> result = skillService.findSkills(null, subDomainId);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).name()).isEqualTo("Spring Boot");
        verifyNoInteractions(domainRepository);
    }

    @Test
    void findSkills_bySubDomainId_subDomainNotFound_throws404() {
        UUID subDomainId = UUID.randomUUID();
        when(subDomainRepository.existsById(subDomainId)).thenReturn(false);

        assertThatThrownBy(() -> skillService.findSkills(null, subDomainId))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    void findSkills_byDomainId_returnsSkillsForDomain() {
        UUID domainId = UUID.randomUUID();
        Skill skill = skill("Docker");
        when(domainRepository.existsById(domainId)).thenReturn(true);
        when(skillRepository.findByDomainId(domainId)).thenReturn(List.of(skill));

        List<SkillResponse> result = skillService.findSkills(domainId, null);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).name()).isEqualTo("Docker");
        verifyNoInteractions(subDomainRepository);
    }

    @Test
    void findSkills_byDomainId_domainNotFound_throws404() {
        UUID domainId = UUID.randomUUID();
        when(domainRepository.existsById(domainId)).thenReturn(false);

        assertThatThrownBy(() -> skillService.findSkills(domainId, null))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    void findSkills_bothParams_subDomainIdTakesPrecedence() {
        UUID domainId = UUID.randomUUID();
        UUID subDomainId = UUID.randomUUID();
        Skill skill = skill("Git");
        when(subDomainRepository.existsById(subDomainId)).thenReturn(true);
        when(skillRepository.findBySubDomainId(subDomainId)).thenReturn(List.of(skill));

        List<SkillResponse> result = skillService.findSkills(domainId, subDomainId);

        assertThat(result).hasSize(1);
        verify(skillRepository).findBySubDomainId(subDomainId);
        verifyNoInteractions(domainRepository);
    }

    private Skill skill(String name) {
        Skill s = new Skill();
        ReflectionTestUtils.setField(s, "id", UUID.randomUUID());
        s.setName(name);
        s.setCurated(true);
        return s;
    }
}
