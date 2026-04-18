package com.projectbourne.backend.controller;

import com.projectbourne.backend.dto.DomainResponse;
import com.projectbourne.backend.dto.SubDomainResponse;
import com.projectbourne.backend.service.DomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/domains")
@RequiredArgsConstructor
public class DomainController {

    private final DomainService domainService;

    @GetMapping
    public ResponseEntity<List<DomainResponse>> getAllDomains() {
        return ResponseEntity.ok(domainService.findAllDomains());
    }

    @GetMapping("/{id}/subdomains")
    public ResponseEntity<List<SubDomainResponse>> getSubDomains(@PathVariable UUID id) {
        return ResponseEntity.ok(domainService.findSubDomainsByDomainId(id));
    }
}
