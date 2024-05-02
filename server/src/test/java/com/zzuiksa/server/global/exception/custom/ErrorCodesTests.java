package com.zzuiksa.server.global.exception.custom;

import org.junit.jupiter.api.Test;

import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

public class ErrorCodesTests {

    @Test
    public void errorCodes_duplicateCode_testFail() {
        Set<String> codes = new HashSet<>();
        for (ErrorCodes errorCode : ErrorCodes.values()) {
            assertThat(codes).doesNotContain(errorCode.getCode());
            codes.add(errorCode.getCode());
        }
    }
}
