package com.zzuiksa.server.global.config;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.servers.Server;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        Server localServer = new Server();
        localServer.setDescription("local server");
        localServer.setUrl("http://localhost:8080");

        Server prodServer = new Server();
        prodServer.setDescription("prod server");
        prodServer.setUrl("https://k10a202.p.ssafy.io");

        return new OpenAPI()
                .servers(Arrays.asList(localServer, prodServer))
                // .components(new Components()
                // 	.addSecuritySchemes("bearer-key",
                // 		new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")))
                .info(apiInfo());
    }

    private Info apiInfo() {
        return new Info()
                .title("Zzuiksa APIs")
                .description("This is API specification for A202")
                .version("1.0.0");
    }
}
