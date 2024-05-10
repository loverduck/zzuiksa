package com.zzuiksa.server.domain.auth.repository;

import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Repository;

@Repository
public class RandomNameRepository {

    private final List<String> adjList = List.of("가냘픈", "가는", "가엾은", "강한", "거센", "거친", "검은", "게으른", "고달픈", "고마운", "고운",
            "괜찮은", "굳은", "굵은", "귀여운", "그리운", "기쁜", "긴", "깨끗한", "나쁜", "난데없는", "날랜", "날카로운", "너그러운", "네모난", "노란", "누런",
            "느닷없는", "느린", "더러운", "더운", "동그란", "둥그런", "둥근", "딱한", "뛰어난", "뜨거운", "멋진", "메마른", "모난", "못난", "못된", "못생긴",
            "무거운", "무른", "무서운", "미끄러운", "미운", "바람직한", "반가운", "밝은", "보드라운", "부드러운", "붉은", "빠른", "빨간", "뻘건", "뽀얀", "뿌연",
            "새로운", "서툰", "성가신", "센", "수줍은", "쉬운", "수상한", "슬픈", "시원찮은", "쌀쌀맞은", "쏜살같은", "아름다운", "아쉬운", "아픈", "안쓰러운",
            "안타까운", "약빠른", "약은", "얇은", "어두운", "어린", "언짢은", "엄청난", "예쁜", "올바른", "옳은", "외로운", "우스운", "의심스런", "작은", "잘난",
            "잘생긴", "재미있는", "젊은", "점잖은", "조그만", "즐거운", "지혜로운", "짓궂은", "짧은", "케케묵은", "큰", "푸른", "한결같은", "희망찬", "흰",
            "힘겨운");

    private final List<String> nounList = List.of("햄스터");

    private final Random random = new Random();

    public String getRandomName() {
        String adj = getRandom(adjList);
        String noun = getRandom(nounList);
        return String.format("%s %s", adj, noun);
    }

    private String getRandom(List<String> list) {
        int bound = list.size();
        int index = random.nextInt(bound);
        return list.get(index);
    }
}
