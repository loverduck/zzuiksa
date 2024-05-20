package com.zzuiksa.server.global.oauth.data.request;

import lombok.Builder;

@Builder
public class KakaoTokenRequest {

    private String grant_type;
    private String client_id;
    private String redirect_uri;
    private String code;
    private String client_secret;
}
