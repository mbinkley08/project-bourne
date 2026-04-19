package com.projectbourne.backend.repository;

import com.projectbourne.backend.entity.Skill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface SkillRepository extends JpaRepository<Skill, UUID> {

    List<Skill> findAllByOrderByNameAsc();

    @Query("SELECT DISTINCT s FROM Skill s JOIN s.subDomains sd WHERE sd.id = :subDomainId ORDER BY s.name ASC")
    List<Skill> findBySubDomainId(@Param("subDomainId") UUID subDomainId);

    @Query("SELECT DISTINCT s FROM Skill s JOIN s.subDomains sd WHERE sd.domain.id = :domainId ORDER BY s.name ASC")
    List<Skill> findByDomainId(@Param("domainId") UUID domainId);
}
