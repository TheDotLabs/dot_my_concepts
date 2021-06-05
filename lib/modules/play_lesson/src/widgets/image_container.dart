import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(child: CircularLoading()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
