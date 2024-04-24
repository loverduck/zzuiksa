package com.zzuiksa.server.global.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.lang.reflect.ParameterizedType;

@RestControllerAdvice
@RequiredArgsConstructor
public class SuccessResponseAdvice implements ResponseBodyAdvice<Object> {

    private final ObjectMapper objectMapper;

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        Class<?> type = returnType.getParameterType();
        // Method의 반환 형식이 ResponseEntity일 경우 제네릭의 타입 사용
        if (ResponseEntity.class.isAssignableFrom(type)) {
            try {
                ParameterizedType parameterizedType = (ParameterizedType) returnType.getGenericParameterType();
                type = (Class<?>) parameterizedType.getActualTypeArguments()[0];
            } catch (ClassCastException | ArrayIndexOutOfBoundsException ex) {
                return false;
            }
        }
        if (SuccessResponse.class.isAssignableFrom(type) || ErrorResponse.class.isAssignableFrom(type)) {
            return false;
        }
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        SuccessResponse<?> successResponse = new SuccessResponse<>(body);
        if (MappingJackson2HttpMessageConverter.class.isAssignableFrom(selectedConverterType)) {
            return successResponse;
        }
        try {
            response.getHeaders().set("Content-Type", "application/json");
            return objectMapper.writeValueAsString(successResponse);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }
}
