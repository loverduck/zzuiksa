import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class GifticonOverview extends StatefulWidget {
  final int expiringGifticonsCount;

  const GifticonOverview({Key? key, required this.expiringGifticonsCount}) : super(key: key);

  @override
  State<GifticonOverview> createState() => _GifticonOverviewState();
}

class _GifticonOverviewState extends State<GifticonOverview> {
  @override
  void initState() {
    super.initState();
    fetchOverview();
  }

  Future<void> fetchOverview() async {

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        width: 400,
        height: 100,
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Constants.main100,
                  border: Border.all(color: Constants.main600, width: 2.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  '곧 기간 만료되는 \n${widget.expiringGifticonsCount}개의 기프티콘이 있어요!',
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 100,
              height: 120,
              child: Image(
                image: AssetImage('assets/images/temp.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}