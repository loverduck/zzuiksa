import 'dart:async';

import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'gifticon_list_item.dart';
import 'package:client/styles.dart';

class GifticonList extends StatefulWidget {
  final List<GifticonPreview> gifticons;
  final Function() onRefresh;
  final String Function(GifticonPreview gifticon) getStatusStamp;

  GifticonList({Key? key, required this.gifticons, required this.onRefresh, required this.getStatusStamp}) : super(key: key);

  @override
  _GifticonListState createState() => _GifticonListState();
}

class _GifticonListState extends State<GifticonList> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _setupTimer();
  }

  void _setupTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      widget.onRefresh();  // 부모 위젯에서 제공된 데이터 새로고침 함수 호출
    });
  }

  @override
  void dispose() {
    _timer?.cancel();  // 타이머 사용 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  buildGridView(widget.gifticons.where((i) => i.isUsed == 'UNUSED' || i.isUsed == 'INUSE').toList(), 2),
                  buildGridView(widget.gifticons.where((i) => i.isUsed == 'USED').toList(), 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(List<GifticonPreview> filteredGifticons, int crossAxisCount) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: filteredGifticons.length,
      itemBuilder: (context, index) {
        //
        final gifticon = filteredGifticons[index];
        print("-----------Rendering Gifticon: ${gifticon.name}");
        return GifticonListItem(gifticonPreview: gifticon);
      },
    );
  }
}

