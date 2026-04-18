package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SubDomainResponse;
import com.projectbourne.backend.entity.Domain;
import com.projectbourne.backend.entity.SubDomain;
import com.projectbourne.backend.repository.DomainRepository;
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
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DomainServiceTest {

    @Mock
    private DomainRepository domainRepository;

    @Mock
    private SubDomainRepository subDomainRepository;

    @InjectMocks
    private DomainService domainService;

    @Test
    void findAllDomains_returnsMappedResponses() {
        Domain domain = domain(UUID.randomUUID());
        when(domainRepository.findAllByOrderByNameAsc()).thenReturn(List.of(domain));

        List<DomainResponse> result = domainService.findAllDomains();

        assertThat(result).hasSize(1);
        assertThat(result.get(0).id()).isEqualTo(domain.getId());
        assertThat(result.get(0).name()).isEqualTo("Software Engineering");
    }

    @Test
    void findAllDomains_emptyRepository_returnsEmptyList() {
        when(domainRepository.findAllByOrderByNameAsc()).thenReturn(List.of());

        List<DomainResponse> result = domainService.findAllDomains();

        assertThat(result).isEmpty();
    }

    @Test
    void findSubDomainsByDomainId_domainNotFound_throws404() {
        UUID id = UUID.randomUUID();
        when(domainRepository.existsById(id)).thenReturn(false);

        assertThatThrownBy(() -> domainService.findSubDomainsByDomainId(id))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }

    @Test
    void findSubDomainsByDomainId_returnsMappedResponses() {
        UUID domainId = UUID.randomUUID();
        Domain domain = domain(domainId);
        SubDomain subDomain = subDomain(domain);

        when(domainRepository.existsById(domainId)).thenReturn(true);
        when(subDomainRepository.findByDomainIdOrderByNameAsc(domainId)).thenReturn(List.of(subDomain));

        List<SubDomainResponse> result = domainService.findSubDomainsByDomainId(domainId);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).name()).isEqualTo("Backend");
        assertThat(result.get(0).domainId()).isEqualTo(domainId);
    }

    @Test
    void findSubDomainsByDomainId_noSubDomains_returnsEmptyList() {
        UUID domainId = UUID.randomUUID();
        when(domainRepository.existsById(domainId)).thenReturn(true);
        when(subDomainRepository.findByDomainIdOrderByNameAsc(domainId)).thenReturn(List.of());

        List<SubDomainResponse> result = domainService.findSubDomainsByDomainId(domainId);

        assertThat(result).isEmpty();
    }

    private Domain domain(UUID id) {
        Domain d = new Domain();
        ReflectionTestUtils.setField(d, "id", id);
        d.setName("Software Engineering");
        return d;
    }

    private SubDomain subDomain(Domain domain) {
        SubDomain sd = new SubDomain();
        ReflectionTestUtils.setField(sd, "id", UUID.randomUUID());
        sd.setDomain(domain);
        sd.setName("Backend");
        return sd;
    }
}
