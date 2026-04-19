CREATE TABLE skill (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name       VARCHAR(100) NOT NULL UNIQUE,
    curated    BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE skill_sub_domain (
    skill_id      UUID NOT NULL REFERENCES skill(id),
    sub_domain_id UUID NOT NULL REFERENCES sub_domain(id),
    PRIMARY KEY (skill_id, sub_domain_id)
);

CREATE INDEX idx_skill_sub_domain_skill_id      ON skill_sub_domain(skill_id);
CREATE INDEX idx_skill_sub_domain_sub_domain_id ON skill_sub_domain(sub_domain_id);
