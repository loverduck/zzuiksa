package com.zzuiksa.server.global.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.convert.DurationUnit;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;
import java.time.temporal.ChronoUnit;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "token")
public class TokenConfig {

    private String issuer;

    private String secret;

    @DurationUnit(ChronoUnit.SECONDS)
    private Duration timeToLive;
}
