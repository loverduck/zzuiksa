import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../model/gifticon_model.dart';
import 'gifticon_list_item.dart';
import 'package:client/styles.dart';

class GifticonList extends StatelessWidget {
  final List<GifticonPreview> gifticons;

  GifticonList({Key? key, required this.gifticons}) : super(key: key);

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
                  buildGridView(gifticons.where((i) => i.isUsed == '미사용' || i.isUsed == '사용중').toList(), 2),
                  buildGridView(gifticons.where((i) => i.isUsed == '사용완료').toList(), 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(List<GifticonPreview> filteredGifticons, int crossAxisCount) {
    // final int itemCount = gifticons.length;
    // final int rowCount = (itemCount + crossAxisCount - 1) ~/ crossAxisCount; // Calculate the total number of rows
    //
    // return GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: crossAxisCount,
    //     crossAxisSpacing: 0,
    //     mainAxisSpacing: 0,
    //   ),
    //   itemCount: itemCount,
    //   itemBuilder: (context, index) {
    //     final bool isRightEdge = (index + 1) % crossAxisCount == 0;
    //     final bool isLastRow = index >= (rowCount - 1) * crossAxisCount; // Check if it's in the last row
    //
    //     return Container(
    //       decoration: BoxDecoration(
    //         border: Border(
    //           right: BorderSide(width: isRightEdge ? 0 : 1, color: isRightEdge ? Colors.transparent : Colors.grey[300]!),
    //           bottom: BorderSide(width: isLastRow ? 0 : 1, color: isLastRow ? Colors.transparent : Colors.grey[300]!),
    //         ),
    //       ),
    //       child: GifticonListItem(
    //         gifticon: gifticons[index],
    //       ),
    //     );
    //   },
    // );
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: filteredGifticons.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: (index + 1) % crossAxisCount == 0 ? 0 : 1, color: Colors.grey[300]!),
              bottom: BorderSide(width: index >= (filteredGifticons.length / crossAxisCount).floor() * crossAxisCount ? 0 : 1, color: Colors.grey[300]!),
            ),
          ),
          child: GifticonListItem(
            gifticonPreview: filteredGifticons[index],
          ),
        );
      },
    );
  }
}

