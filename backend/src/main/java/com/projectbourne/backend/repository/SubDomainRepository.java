package com.projectbourne.backend.repository;

import com.projectbourne.backend.entity.SubDomain;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SubDomainRepository extends JpaRepository<SubDomain, UUID> {
    List<SubDomain> findByDomain_IdOrderByNameAsc(UUID domainId);
}
