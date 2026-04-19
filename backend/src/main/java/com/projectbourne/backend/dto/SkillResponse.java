package com.projectbourne.backend.dto;

import java.util.UUID;

public record SkillResponse(UUID id, String name, boolean curated) {
}
