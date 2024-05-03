package com.zzuiksa.server.global.exception.custom;

import static org.assertj.core.api.Assertions.*;

import java.util.HashSet;
import java.util.Set;

import org.junit.jupiter.api.Test;

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
