package com.projectbourne.backend.service;

import com.projectbourne.backend.dto.SkillResponse;
import com.projectbourne.backend.entity.Skill;
import com.projectbourne.backend.repository.DomainRepository;
import com.projectbourne.backend.repository.SkillRepository;
import com.projectbourne.backend.repository.SubDomainRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SkillService {

    private final SkillRepository skillRepository;
    private final DomainRepository domainRepository;
    private final SubDomainRepository subDomainRepository;

    public List<SkillResponse> findSkills(UUID domainId, UUID subDomainId) {
        if (subDomainId != null) {
            if (!subDomainRepository.existsById(subDomainId)) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Sub-domain not found");
            }
            return toResponse(skillRepository.findBySubDomainId(subDomainId));
        }
        if (domainId != null) {
            if (!domainRepository.existsById(domainId)) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Domain not found");
            }
            return toResponse(skillRepository.findByDomainId(domainId));
        }
        return toResponse(skillRepository.findAllByOrderByNameAsc());
    }

    private List<SkillResponse> toResponse(List<Skill> skills) {
        return skills.stream()
                .map(s -> new SkillResponse(s.getId(), s.getName(), s.isCurated()))
                .toList();
    }
}
