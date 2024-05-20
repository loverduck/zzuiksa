package com.zzuiksa.server.domain.member.entity;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import com.zzuiksa.server.global.exception.InvalidMemberNameException;

public class MemberTests {

    @Test
    public void setName_null_throwsInvalidMemberNameException() {
        // given
        String name = null;
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @Test
    public void setName_lengthLessThan1_throwInvalidMemberNameException() {
        // given
        String name = "";
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"12345678901", "123456789012"})
    public void setName_lengthGreaterThan10_throwInvalidMemberNameException(String name) {
        // given
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {" ", "  ", "          "})
    public void setName_onlySpaces_throwsInvalidMemberNameException(String name) {
        // given
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {" ok", "ok ", " ok "})
    public void setName_untrimmed_throwsInvalidMemberNameException(String name) {
        // given
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"a b", "a b c", "a b c d"})
    public void setName_singleSpaceBetween_success(String name) {
        // given
        Member member = new Member();

        // when
        member.setName(name);

        // then
        assertThat(member.getName()).isEqualTo(name);
    }

    @ParameterizedTest
    @ValueSource(strings = {"a  b", "a   b"})
    public void setName_multipleConsecutiveSpaces_throwsInvalidMemberNameException(String name) {
        // given
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"asdf*", "%123", "!@ #! @#"})
    public void setName_invalidCharacters_throwsInvalidMemberNameException(String name) {
        // given
        Member member = new Member();

        // when & then
        assertThatThrownBy(() -> member.setName(name))
                .isInstanceOf(InvalidMemberNameException.class);
    }

    @ParameterizedTest
    @ValueSource(strings = {"aAzZxX", "1a2sb3", "A9z8l", "a", "1234567890"})
    public void setName_alphabetOrDigitCharacters_success(String name) {
        // given
        Member member = new Member();

        // when
        member.setName(name);

        // then
        assertThat(member.getName()).isEqualTo(name);
    }

    @ParameterizedTest
    @ValueSource(strings = {"안녕하세요안녕하세요", "안 녕 하 세 요", "안1녕2하3세4요5", "가a나b다c라d마e"})
    public void setName_completeHangulCharacters_success(String name) {
        // given
        Member member = new Member();

        // when
        member.setName(name);

        // then
        assertThat(member.getName()).isEqualTo(name);
    }

    @ParameterizedTest
    @ValueSource(strings = {"ㄱㄴㄷㄹㅁ ㅎㅎ", "ㅏㅑㅓㅕㅡㅣ"})
    public void setName_hangulCharacters_success(String name) {
        // given
        Member member = new Member();

        // when
        member.setName(name);

        // then
        assertThat(member.getName()).isEqualTo(name);
    }
}
