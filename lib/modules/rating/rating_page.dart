import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({
    Key? key,
    required this.ratings,
    required this.userId,
  }) : super(key: key);

  final List<Rating> ratings;
  final String userId;

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings & Reviews'),
      ),
      body: ListView(
        children: [
          SectionDivider(),
          ...widget.ratings.map(
            (e) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: FutureBuilder<MyUser?>(
                      future: _getFuture(widget.userId),
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: CachedNetworkImageProvider(
                                snapshot.data?.avatar ?? "-",
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              snapshot.data?.name ?? '---',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            Text(
                              '${_getStars(e.number.toInt())} ${e.number}',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      e.review ?? '--No Review--',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  isThreeLine: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                SectionDivider(),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getStars(int number) {
    if (number == 1) {
      return '⭐';
    } else if (number == 2) {
      return '⭐⭐';
    } else if (number == 3) {
      return '⭐⭐⭐';
    } else if (number == 4) {
      return '⭐⭐⭐⭐';
    } else {
      return '⭐⭐⭐⭐⭐';
    }
  }

  Future<MyUser?> _getFuture(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return MyUser.fromJson(doc.data() ?? {});
  }
}
