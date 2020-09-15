import 'package:flutter/material.dart';

import 'models/my_event.dart';

class RecordLessonPage extends StatefulWidget {
  @override
  _RecordLessonPageState createState() => _RecordLessonPageState();
}

class _RecordLessonPageState extends State<RecordLessonPage> {
  final _controller = PageController();
  int _pageIndex = 0;
  final _imageList = [
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_2.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_4.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_5.jpeg",
  ];

  final _eventList = <MyEvent>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record Lesson"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black87,
              height: 400,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                onPageChanged: (val) {
                  _pageIndex = val;
                  _addEvent(name: Events.changeImage, index: val);
                },
                scrollDirection: Axis.horizontal,
                children: [
                  ..._imageList.map((e) => Image.network(e)),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    if (_pageIndex > 0) {
                      _pageIndex--;
                      _controller.jumpToPage(_pageIndex);
                    }
                  },
                  child: Text("PREVIOUS"),
                ),
                FlatButton(
                  onPressed: () {
                    if (_pageIndex < _imageList.length - 1) {
                      _pageIndex++;
                      _controller.jumpToPage(_pageIndex);
                    }
                  },
                  child: Text("NEXT"),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                ..._eventList.map(
                  (e) => Text('${e.time} : ${e.event.getName()} ; ${e.index}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _addEvent({Events name, int index}) {
    setState(() {
      _eventList.add(
        MyEvent(
          event: name,
          index: index,
          time: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });
  }
}
