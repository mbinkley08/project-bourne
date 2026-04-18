package com.projectbourne.backend.repository;

import com.projectbourne.backend.entity.SubDomain;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface SubDomainRepository extends JpaRepository<SubDomain, UUID> {
    @Query("SELECT sd FROM SubDomain sd WHERE sd.domain.id = :domainId ORDER BY sd.name ASC")
    List<SubDomain> findByDomainIdOrderByNameAsc(@Param("domainId") UUID domainId);
}
