package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SubDomainResponse;
import com.projectbourne.backend.repository.DomainRepository;
import com.projectbourne.backend.repository.SubDomainRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DomainService {

    private final DomainRepository domainRepository;
    private final SubDomainRepository subDomainRepository;

    public List<DomainResponse> findAllDomains() {
        return domainRepository.findAllByOrderByNameAsc().stream()
                .map(d -> new DomainResponse(d.getId(), d.getName()))
                .toList();
    }

    public List<SubDomainResponse> findSubDomainsByDomainId(UUID domainId) {
        if (!domainRepository.existsById(domainId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Domain not found");
        }
        return subDomainRepository.findByDomain_IdOrderByNameAsc(domainId).stream()
                .map(sd -> new SubDomainResponse(sd.getId(), sd.getName(), domainId))
                .toList();
    }
}
