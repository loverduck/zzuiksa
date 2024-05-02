package com.zzuiksa.server.global.token.data;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class Jwt {

    private String token;
    private long expiresIn;
}
