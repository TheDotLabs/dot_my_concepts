import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  factory Product({
    String id,
    String title,
    String subtitle,
    List<Description> specifications,
    String designer,
    List<Size> sizes,
    Price price,
    List<MyColor> colors,
    List<String> images,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
abstract class Description with _$Description {
  factory Description({
    String key,
    String value,
  }) = _Description;

  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
}

@freezed
abstract class MyColor with _$MyColor {
  factory MyColor({
    @JsonKey(name: 'color_code') String colorCode,
    @JsonKey(name: 'color_name') String colorName,
  }) = _MyColor;

  factory MyColor.fromJson(Map<String, dynamic> json) =>
      _$MyColorFromJson(json);
}

@freezed
abstract class Size with _$Size {
  factory Size({
    @JsonKey(name: 'key') String key,
    @JsonKey(name: 'value', defaultValue: false) bool value,
    @JsonKey(name: 'info') String info,
  }) = _Size;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
}

@freezed
abstract class Price with _$Price {
  factory Price({
    @JsonKey(name: 'listed_price') String listedPrice,
    @JsonKey(name: 'sale_price') String salePrice,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
