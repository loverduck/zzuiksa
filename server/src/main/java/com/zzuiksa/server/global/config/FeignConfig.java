package com.zzuiksa.server.global.config;

import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.cloud.openfeign.FeignClientsConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@EnableFeignClients(basePackages = "com.zzuiksa.server")
@Import(FeignClientsConfiguration.class)
public class FeignConfig {

}
