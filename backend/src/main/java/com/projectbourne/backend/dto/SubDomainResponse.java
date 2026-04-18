package com.projectbourne.backend.dto;

import java.util.UUID;

public record SubDomainResponse(UUID id, String name, UUID domainId) {
}
