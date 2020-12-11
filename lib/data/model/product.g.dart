// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$_$_ProductFromJson(Map<String, dynamic> json) {
  return _$_Product(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    specifications: (json['specifications'] as List)
        ?.map((e) =>
            e == null ? null : Description.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    designer: json['designer'] as String,
    sizes: (json['sizes'] as List)
        ?.map(
            (e) => e == null ? null : Size.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    price: json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>),
    colors: (json['colors'] as List)
        ?.map((e) =>
            e == null ? null : MyColor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'specifications': instance.specifications,
      'designer': instance.designer,
      'sizes': instance.sizes,
      'price': instance.price,
      'colors': instance.colors,
      'images': instance.images,
    };

_$_Description _$_$_DescriptionFromJson(Map<String, dynamic> json) {
  return _$_Description(
    key: json['key'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$_$_DescriptionToJson(_$_Description instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

_$_MyColor _$_$_MyColorFromJson(Map<String, dynamic> json) {
  return _$_MyColor(
    colorCode: json['color_code'] as String,
    colorName: json['color_name'] as String,
  );
}

Map<String, dynamic> _$_$_MyColorToJson(_$_MyColor instance) =>
    <String, dynamic>{
      'color_code': instance.colorCode,
      'color_name': instance.colorName,
    };

_$_Size _$_$_SizeFromJson(Map<String, dynamic> json) {
  return _$_Size(
    key: json['key'] as String,
    value: json['value'] as bool ?? false,
    info: json['info'] as String,
  );
}

Map<String, dynamic> _$_$_SizeToJson(_$_Size instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'info': instance.info,
    };

_$_Price _$_$_PriceFromJson(Map<String, dynamic> json) {
  return _$_Price(
    listedPrice: json['listed_price'] as String,
    salePrice: json['sale_price'] as String,
  );
}

Map<String, dynamic> _$_$_PriceToJson(_$_Price instance) => <String, dynamic>{
      'listed_price': instance.listedPrice,
      'sale_price': instance.salePrice,
    };
