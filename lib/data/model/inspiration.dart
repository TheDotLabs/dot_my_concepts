import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Inspiration extends Equatable {
  final int id;
  final List<String> imageUrl;
  final String caption;

  Inspiration({
    @required this.id,
    @required this.imageUrl,
    @required this.caption,
  });

  @override
  List<Object> get props => [
        this.id,
        this.imageUrl,
        this.caption,
      ];

  factory Inspiration.fromJson(Map<String, dynamic> json) {
    return Inspiration(
      id: json['id'],
      imageUrl: json['imageUrl'].cast<String>(),
      caption: json['caption'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['caption'] = this.caption;
    return data;
  }
}
