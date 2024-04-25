package com.zzuiksa.server.global.util;

public class Utils {

    /**
     * {@code value}가 {@code min} 이상 {@code max} 이하인지 검사합니다.
     */
    public static boolean isBetween(int value, int min, int max) {
        return min <= value && value <= max;
    }
}
