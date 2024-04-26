package com.zzuiksa.server.global.util;

import org.springframework.util.StringUtils;

public class Utils {

    /**
     * {@code value}가 {@code min} 이상 {@code max} 이하인지 검사합니다.
     */
    public static boolean isBetween(int value, int min, int max) {
        return min <= value && value <= max;
    }

    /**
     * {@code str}이 빈 문자열이 아니고 길이가 {@code min} 이상 {@code max} 이하인지 검사합니다.
     */
    public static boolean hasTextAndLengthBetween(String str, int min, int max) {
        return StringUtils.hasText(str) && isBetween(str.length(), min, max);
    }
}
