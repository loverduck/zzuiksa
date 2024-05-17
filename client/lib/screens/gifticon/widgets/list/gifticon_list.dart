import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'gifticon_list_item.dart';
import 'package:client/styles.dart';

class GifticonList extends StatefulWidget {
  final List<GifticonPreview> gifticons;
  final Function() onRefresh;

  GifticonList({Key? key, required this.gifticons, required this.onRefresh}) : super(key: key);

  @override
  _GifticonListState createState() => _GifticonListState();
}

class _GifticonListState extends State<GifticonList> {
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
                  buildGridView(widget.gifticons.where((i) => i.isUsed == 'UNUSED' || i.isUsed == 'INUSED').toList(), 2),
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

