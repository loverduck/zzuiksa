package com.zzuiksa.server.domain.member.service;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.BDDMockito.*;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;

import com.zzuiksa.server.domain.member.MemberSource;
import com.zzuiksa.server.domain.member.data.response.GetMemberResponse;
import com.zzuiksa.server.domain.member.entity.Member;
import com.zzuiksa.server.domain.member.repository.MemberRepository;
import com.zzuiksa.server.global.exception.custom.CustomException;

@ExtendWith(MockitoExtension.class)
public class MemberServiceTests {

    @Mock
    private MemberRepository memberRepositoryMock;

    @InjectMocks
    private MemberService memberService;

    private Member.MemberBuilder memberBuilder;

    private GetMemberResponse.GetMemberResponseBuilder getMemberResponseBuilder;

    @BeforeEach
    public void setUp() {
        memberBuilder = MemberSource.getTestMemberBuilder();
        getMemberResponseBuilder = MemberSource.getTestGetMemberResponseBuilder();
    }

    @Test
    public void get_byId_success() {
        // given
        Long id = 1L;
        GetMemberResponse getMemberResponse = getMemberResponseBuilder.id(id).build();
        Member member = memberBuilder.id(id).build();

        // when
        GetMemberResponse got = memberService.get(member);

        // then
        assertThat(got).isEqualTo(getMemberResponse);
    }
}
