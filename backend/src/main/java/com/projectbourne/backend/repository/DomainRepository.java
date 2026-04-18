package com.projectbourne.backend.repository;

import com.projectbourne.backend.entity.Domain;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface DomainRepository extends JpaRepository<Domain, UUID> {
    List<Domain> findAllByOrderByNameAsc();
}
