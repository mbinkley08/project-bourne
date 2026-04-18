package com.projectbourne.backend.controller;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SubDomainResponse;
import com.projectbourne.backend.service.DomainService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DomainControllerTest {

    @Mock
    private DomainService domainService;

    @InjectMocks
    private DomainController domainController;

    @Test
    void getAllDomains_returnsOkWithList() {
        List<DomainResponse> domains = List.of(new DomainResponse(UUID.randomUUID(), "Software Engineering"));
        when(domainService.findAllDomains()).thenReturn(domains);

        ResponseEntity<List<DomainResponse>> response = domainController.getAllDomains();

        List<DomainResponse> body = response.getBody();
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(body).isNotNull().hasSize(1);
        assertThat(body.get(0).name()).isEqualTo("Software Engineering");
    }

    @Test
    void getAllDomains_emptyList_returnsOkWithEmptyList() {
        when(domainService.findAllDomains()).thenReturn(List.of());

        ResponseEntity<List<DomainResponse>> response = domainController.getAllDomains();

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isEmpty();
    }

    @Test
    void getSubDomains_validDomain_returnsOkWithList() {
        UUID domainId = UUID.randomUUID();
        List<SubDomainResponse> subDomains = List.of(new SubDomainResponse(UUID.randomUUID(), "Backend", domainId));
        when(domainService.findSubDomainsByDomainId(domainId)).thenReturn(subDomains);

        ResponseEntity<List<SubDomainResponse>> response = domainController.getSubDomains(domainId);

        List<SubDomainResponse> body = response.getBody();
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(body).isNotNull().hasSize(1);
        assertThat(body.get(0).name()).isEqualTo("Backend");
    }

    @Test
    void getSubDomains_domainNotFound_propagates404() {
        UUID domainId = UUID.randomUUID();
        when(domainService.findSubDomainsByDomainId(domainId))
                .thenThrow(new ResponseStatusException(HttpStatus.NOT_FOUND));

        assertThatThrownBy(() -> domainController.getSubDomains(domainId))
                .isInstanceOf(ResponseStatusException.class)
                .extracting(e -> ((ResponseStatusException) e).getStatusCode())
                .isEqualTo(HttpStatus.NOT_FOUND);
    }
}
