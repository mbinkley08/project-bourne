package com.projectbourne.backend.controller;

import com.projectbourne.backend.dto.SkillResponse;
import com.projectbourne.backend.service.SkillService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/skills")
@RequiredArgsConstructor
public class SkillController {

    private final SkillService skillService;

    @GetMapping
    public ResponseEntity<List<SkillResponse>> getSkills(
            @RequestParam(required = false) UUID domainId,
            @RequestParam(required = false) UUID subDomainId) {
        return ResponseEntity.ok(skillService.findSkills(domainId, subDomainId));
    }
}
