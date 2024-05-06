import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'gifticon_list_item.dart';
import 'package:client/styles.dart';

class GifticonList extends StatelessWidget {
  final List<Map<String, dynamic>> tempGifticonsList = [
    // '미사용' 상태의 아이템 8개
    {
      'id': 1,
      'name': '아이스아메리카노T',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '스타벅스',
      'endDate': '2024-05-31',
      'isUsed': '미사용',
    },
    {
      'id': 2,
      'name': '편의점 상품권 3000원권',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': 'GS25',
      'endDate': '2024-05-31',
      'isUsed': '미사용',
    },
    {
      'id': 3,
      'name': '카페라떼',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '이디야',
      'endDate': '2024-06-30',
      'isUsed': '미사용',
    },
    {
      'id': 4,
      'name': '팥빙수',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '설빙',
      'endDate': '2024-07-31',
      'isUsed': '미사용',
    },
    {
      'id': 5,
      'name': '도너츠 세트',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '던킨',
      'endDate': '2024-04-30',
      'isUsed': '미사용',
    },
    {
      'id': 6,
      'name': '치즈 피자',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '피자헛',
      'endDate': '2024-09-30',
      'isUsed': '미사용',
    },
    {
      'id': 7,
      'name': '샌드위치',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '서브웨이',
      'endDate': '2024-08-31',
      'isUsed': '미사용',
    },
    {
      'id': 8,
      'name': '에스프레소',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '커피빈',
      'endDate': '2024-10-31',
      'isUsed': '미사용',
    },

    // '사용중' 상태의 아이템 8개
    {
      'id': 9,
      'name': '치킨 세트',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': 'BBQ',
      'endDate': '2024-06-30',
      'isUsed': '사용중',
    },
    {
      'id': 10,
      'name': '버거 세트',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '맥도날드',
      'endDate': '2024-07-31',
      'isUsed': '사용중',
    },
    {
      'id': 11,
      'name': '아이스크림 콘',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '배스킨라빈스',
      'endDate': '2024-05-31',
      'isUsed': '사용중',
    },
    {
      'id': 12,
      'name': '콜라 1.5L',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': 'GS25',
      'endDate': '2024-06-30',
      'isUsed': '사용중',
    },
    {
      'id': 13,
      'name': '핫도그',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '롯데리아',
      'endDate': '2024-07-31',
      'isUsed': '사용중',
    },
    {
      'id': 14,
      'name': '크림 파스타',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '아웃백',
      'endDate': '2024-08-31',
      'isUsed': '사용중',
    },
    {
      'id': 15,
      'name': '수박 주스',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '쥬시',
      'endDate': '2024-09-30',
      'isUsed': '사용중',
    },
    {
      'id': 16,
      'name': '티라미수 케이크',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '투썸플레이스',
      'endDate': '2024-10-31',
      'isUsed': '사용중',
    },

    // '사용완료' 상태의 아이템 8개
    {
      'id': 17,
      'name': '아메리카노',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '스타벅스',
      'endDate': '2023-12-31',
      'isUsed': '사용완료',
    },
    {
      'id': 18,
      'name': '초콜릿 케이크',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '파리바게트',
      'endDate': '2024-01-31',
      'isUsed': '사용완료',
    },
    {
      'id': 19,
      'name': '바닐라 라떼',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '카페베네',
      'endDate': '2023-11-30',
      'isUsed': '사용완료',
    },
    {
      'id': 20,
      'name': '핫초코',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '이디야',
      'endDate': '2024-02-28',
      'isUsed': '사용완료',
    },
    {
      'id': 21,
      'name': '베이글',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '블루보틀',
      'endDate': '2023-10-31',
      'isUsed': '사용완료',
    },
    {
      'id': 22,
      'name': '카푸치노',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '커피빈',
      'endDate': '2023-09-30',
      'isUsed': '사용완료',
    },
    {
      'id': 23,
      'name': '치즈 케이크',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '투썸플레이스',
      'endDate': '2024-04-30',
      'isUsed': '사용완료',
    },
    {
      'id': 24,
      'name': '딸기 스무디',
      'url': '/assets/images/tempGifticon.jpeg',
      'store': '주스킹',
      'endDate': '2023-08-31',
      'isUsed': '사용완료',
    },
  ];




  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> availableGifticons = [];
    List<Map<String, dynamic>> usedGifticons = [];

    for (var gifticon in tempGifticonsList) {
      if (gifticon['isUsed'] == '사용완료') {
        usedGifticons.add(gifticon);
      } else if (gifticon['isUsed'] == '사용중' || gifticon['isUsed'] == '미사용' ){
        availableGifticons.add(gifticon);
      }
    }


    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Constants.main100,
          border: Border.all(color: Constants.main600, width: 2.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            TabBar(
              indicatorColor: Constants.main400,
              labelColor: Constants.main400,
              labelStyle: myTheme.textTheme.displayMedium,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: myTheme.textTheme.displayMedium?.copyWith(
                color: Colors.grey,
              ),
              tabs: const [
                Tab(text: '사용 가능'),
                Tab(text: '사용 완료'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: availableGifticons.length,
                    itemBuilder: (context, index) {
                      return GifticonListItem(
                        gifticon: availableGifticons[index],
                      );
                    },
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: usedGifticons.length,
                    itemBuilder: (context, index) {
                      return GifticonListItem(
                        gifticon: usedGifticons[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}