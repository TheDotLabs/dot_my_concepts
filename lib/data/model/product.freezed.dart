// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
class _$ProductTearOff {
  const _$ProductTearOff();

// ignore: unused_element
  _Product call(
      {String id,
      String title,
      String subtitle,
      List<Description> specifications,
      String designer,
      List<Size> sizes,
      Price price,
      List<MyColor> colors,
      List<String> images}) {
    return _Product(
      id: id,
      title: title,
      subtitle: subtitle,
      specifications: specifications,
      designer: designer,
      sizes: sizes,
      price: price,
      colors: colors,
      images: images,
    );
  }

// ignore: unused_element
  Product fromJson(Map<String, Object> json) {
    return Product.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Product = _$ProductTearOff();

/// @nodoc
mixin _$Product {
  String get id;
  String get title;
  String get subtitle;
  List<Description> get specifications;
  String get designer;
  List<Size> get sizes;
  Price get price;
  List<MyColor> get colors;
  List<String> get images;

  Map<String, dynamic> toJson();
  $ProductCopyWith<Product> get copyWith;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String subtitle,
      List<Description> specifications,
      String designer,
      List<Size> sizes,
      Price price,
      List<MyColor> colors,
      List<String> images});

  $PriceCopyWith<$Res> get price;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object specifications = freezed,
    Object designer = freezed,
    Object sizes = freezed,
    Object price = freezed,
    Object colors = freezed,
    Object images = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      specifications: specifications == freezed
          ? _value.specifications
          : specifications as List<Description>,
      designer: designer == freezed ? _value.designer : designer as String,
      sizes: sizes == freezed ? _value.sizes : sizes as List<Size>,
      price: price == freezed ? _value.price : price as Price,
      colors: colors == freezed ? _value.colors : colors as List<MyColor>,
      images: images == freezed ? _value.images : images as List<String>,
    ));
  }

  @override
  $PriceCopyWith<$Res> get price {
    if (_value.price == null) {
      return null;
    }
    return $PriceCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value));
    });
  }
}

/// @nodoc
abstract class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) then) =
      __$ProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String subtitle,
      List<Description> specifications,
      String designer,
      List<Size> sizes,
      Price price,
      List<MyColor> colors,
      List<String> images});

  @override
  $PriceCopyWith<$Res> get price;
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(_Product _value, $Res Function(_Product) _then)
      : super(_value, (v) => _then(v as _Product));

  @override
  _Product get _value => super._value as _Product;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object specifications = freezed,
    Object designer = freezed,
    Object sizes = freezed,
    Object price = freezed,
    Object colors = freezed,
    Object images = freezed,
  }) {
    return _then(_Product(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      specifications: specifications == freezed
          ? _value.specifications
          : specifications as List<Description>,
      designer: designer == freezed ? _value.designer : designer as String,
      sizes: sizes == freezed ? _value.sizes : sizes as List<Size>,
      price: price == freezed ? _value.price : price as Price,
      colors: colors == freezed ? _value.colors : colors as List<MyColor>,
      images: images == freezed ? _value.images : images as List<String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Product implements _Product {
  _$_Product(
      {this.id,
      this.title,
      this.subtitle,
      this.specifications,
      this.designer,
      this.sizes,
      this.price,
      this.colors,
      this.images});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$_$_ProductFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final List<Description> specifications;
  @override
  final String designer;
  @override
  final List<Size> sizes;
  @override
  final Price price;
  @override
  final List<MyColor> colors;
  @override
  final List<String> images;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, subtitle: $subtitle, specifications: $specifications, designer: $designer, sizes: $sizes, price: $price, colors: $colors, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Product &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.specifications, specifications) ||
                const DeepCollectionEquality()
                    .equals(other.specifications, specifications)) &&
            (identical(other.designer, designer) ||
                const DeepCollectionEquality()
                    .equals(other.designer, designer)) &&
            (identical(other.sizes, sizes) ||
                const DeepCollectionEquality().equals(other.sizes, sizes)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.colors, colors) ||
                const DeepCollectionEquality().equals(other.colors, colors)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(specifications) ^
      const DeepCollectionEquality().hash(designer) ^
      const DeepCollectionEquality().hash(sizes) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(colors) ^
      const DeepCollectionEquality().hash(images);

  @override
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProductToJson(this);
  }
}

abstract class _Product implements Product {
  factory _Product(
      {String id,
      String title,
      String subtitle,
      List<Description> specifications,
      String designer,
      List<Size> sizes,
      Price price,
      List<MyColor> colors,
      List<String> images}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  List<Description> get specifications;
  @override
  String get designer;
  @override
  List<Size> get sizes;
  @override
  Price get price;
  @override
  List<MyColor> get colors;
  @override
  List<String> get images;
  @override
  _$ProductCopyWith<_Product> get copyWith;
}

Description _$DescriptionFromJson(Map<String, dynamic> json) {
  return _Description.fromJson(json);
}

/// @nodoc
class _$DescriptionTearOff {
  const _$DescriptionTearOff();

// ignore: unused_element
  _Description call({String key, String value}) {
    return _Description(
      key: key,
      value: value,
    );
  }

// ignore: unused_element
  Description fromJson(Map<String, Object> json) {
    return Description.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Description = _$DescriptionTearOff();

/// @nodoc
mixin _$Description {
  String get key;
  String get value;

  Map<String, dynamic> toJson();
  $DescriptionCopyWith<Description> get copyWith;
}

/// @nodoc
abstract class $DescriptionCopyWith<$Res> {
  factory $DescriptionCopyWith(
          Description value, $Res Function(Description) then) =
      _$DescriptionCopyWithImpl<$Res>;
  $Res call({String key, String value});
}

/// @nodoc
class _$DescriptionCopyWithImpl<$Res> implements $DescriptionCopyWith<$Res> {
  _$DescriptionCopyWithImpl(this._value, this._then);

  final Description _value;
  // ignore: unused_field
  final $Res Function(Description) _then;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as String,
    ));
  }
}

/// @nodoc
abstract class _$DescriptionCopyWith<$Res>
    implements $DescriptionCopyWith<$Res> {
  factory _$DescriptionCopyWith(
          _Description value, $Res Function(_Description) then) =
      __$DescriptionCopyWithImpl<$Res>;
  @override
  $Res call({String key, String value});
}

/// @nodoc
class __$DescriptionCopyWithImpl<$Res> extends _$DescriptionCopyWithImpl<$Res>
    implements _$DescriptionCopyWith<$Res> {
  __$DescriptionCopyWithImpl(
      _Description _value, $Res Function(_Description) _then)
      : super(_value, (v) => _then(v as _Description));

  @override
  _Description get _value => super._value as _Description;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
  }) {
    return _then(_Description(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Description implements _Description {
  _$_Description({this.key, this.value});

  factory _$_Description.fromJson(Map<String, dynamic> json) =>
      _$_$_DescriptionFromJson(json);

  @override
  final String key;
  @override
  final String value;

  @override
  String toString() {
    return 'Description(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Description &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(value);

  @override
  _$DescriptionCopyWith<_Description> get copyWith =>
      __$DescriptionCopyWithImpl<_Description>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DescriptionToJson(this);
  }
}

abstract class _Description implements Description {
  factory _Description({String key, String value}) = _$_Description;

  factory _Description.fromJson(Map<String, dynamic> json) =
      _$_Description.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  _$DescriptionCopyWith<_Description> get copyWith;
}

MyColor _$MyColorFromJson(Map<String, dynamic> json) {
  return _MyColor.fromJson(json);
}

/// @nodoc
class _$MyColorTearOff {
  const _$MyColorTearOff();

// ignore: unused_element
  _MyColor call(
      {@JsonKey(name: 'color_code') String colorCode,
      @JsonKey(name: 'color_name') String colorName}) {
    return _MyColor(
      colorCode: colorCode,
      colorName: colorName,
    );
  }

// ignore: unused_element
  MyColor fromJson(Map<String, Object> json) {
    return MyColor.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $MyColor = _$MyColorTearOff();

/// @nodoc
mixin _$MyColor {
  @JsonKey(name: 'color_code')
  String get colorCode;
  @JsonKey(name: 'color_name')
  String get colorName;

  Map<String, dynamic> toJson();
  $MyColorCopyWith<MyColor> get copyWith;
}

/// @nodoc
abstract class $MyColorCopyWith<$Res> {
  factory $MyColorCopyWith(MyColor value, $Res Function(MyColor) then) =
      _$MyColorCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'color_code') String colorCode,
      @JsonKey(name: 'color_name') String colorName});
}

/// @nodoc
class _$MyColorCopyWithImpl<$Res> implements $MyColorCopyWith<$Res> {
  _$MyColorCopyWithImpl(this._value, this._then);

  final MyColor _value;
  // ignore: unused_field
  final $Res Function(MyColor) _then;

  @override
  $Res call({
    Object colorCode = freezed,
    Object colorName = freezed,
  }) {
    return _then(_value.copyWith(
      colorCode: colorCode == freezed ? _value.colorCode : colorCode as String,
      colorName: colorName == freezed ? _value.colorName : colorName as String,
    ));
  }
}

/// @nodoc
abstract class _$MyColorCopyWith<$Res> implements $MyColorCopyWith<$Res> {
  factory _$MyColorCopyWith(_MyColor value, $Res Function(_MyColor) then) =
      __$MyColorCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'color_code') String colorCode,
      @JsonKey(name: 'color_name') String colorName});
}

/// @nodoc
class __$MyColorCopyWithImpl<$Res> extends _$MyColorCopyWithImpl<$Res>
    implements _$MyColorCopyWith<$Res> {
  __$MyColorCopyWithImpl(_MyColor _value, $Res Function(_MyColor) _then)
      : super(_value, (v) => _then(v as _MyColor));

  @override
  _MyColor get _value => super._value as _MyColor;

  @override
  $Res call({
    Object colorCode = freezed,
    Object colorName = freezed,
  }) {
    return _then(_MyColor(
      colorCode: colorCode == freezed ? _value.colorCode : colorCode as String,
      colorName: colorName == freezed ? _value.colorName : colorName as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_MyColor implements _MyColor {
  _$_MyColor(
      {@JsonKey(name: 'color_code') this.colorCode,
      @JsonKey(name: 'color_name') this.colorName});

  factory _$_MyColor.fromJson(Map<String, dynamic> json) =>
      _$_$_MyColorFromJson(json);

  @override
  @JsonKey(name: 'color_code')
  final String colorCode;
  @override
  @JsonKey(name: 'color_name')
  final String colorName;

  @override
  String toString() {
    return 'MyColor(colorCode: $colorCode, colorName: $colorName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyColor &&
            (identical(other.colorCode, colorCode) ||
                const DeepCollectionEquality()
                    .equals(other.colorCode, colorCode)) &&
            (identical(other.colorName, colorName) ||
                const DeepCollectionEquality()
                    .equals(other.colorName, colorName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(colorCode) ^
      const DeepCollectionEquality().hash(colorName);

  @override
  _$MyColorCopyWith<_MyColor> get copyWith =>
      __$MyColorCopyWithImpl<_MyColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyColorToJson(this);
  }
}

abstract class _MyColor implements MyColor {
  factory _MyColor(
      {@JsonKey(name: 'color_code') String colorCode,
      @JsonKey(name: 'color_name') String colorName}) = _$_MyColor;

  factory _MyColor.fromJson(Map<String, dynamic> json) = _$_MyColor.fromJson;

  @override
  @JsonKey(name: 'color_code')
  String get colorCode;
  @override
  @JsonKey(name: 'color_name')
  String get colorName;
  @override
  _$MyColorCopyWith<_MyColor> get copyWith;
}

Size _$SizeFromJson(Map<String, dynamic> json) {
  return _Size.fromJson(json);
}

/// @nodoc
class _$SizeTearOff {
  const _$SizeTearOff();

// ignore: unused_element
  _Size call(
      {@JsonKey(name: 'key') String key,
      @JsonKey(name: 'value', defaultValue: false) bool value,
      @JsonKey(name: 'info') String info}) {
    return _Size(
      key: key,
      value: value,
      info: info,
    );
  }

// ignore: unused_element
  Size fromJson(Map<String, Object> json) {
    return Size.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Size = _$SizeTearOff();

/// @nodoc
mixin _$Size {
  @JsonKey(name: 'key')
  String get key;
  @JsonKey(name: 'value', defaultValue: false)
  bool get value;
  @JsonKey(name: 'info')
  String get info;

  Map<String, dynamic> toJson();
  $SizeCopyWith<Size> get copyWith;
}

/// @nodoc
abstract class $SizeCopyWith<$Res> {
  factory $SizeCopyWith(Size value, $Res Function(Size) then) =
      _$SizeCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'key') String key,
      @JsonKey(name: 'value', defaultValue: false) bool value,
      @JsonKey(name: 'info') String info});
}

/// @nodoc
class _$SizeCopyWithImpl<$Res> implements $SizeCopyWith<$Res> {
  _$SizeCopyWithImpl(this._value, this._then);

  final Size _value;
  // ignore: unused_field
  final $Res Function(Size) _then;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
    Object info = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as bool,
      info: info == freezed ? _value.info : info as String,
    ));
  }
}

/// @nodoc
abstract class _$SizeCopyWith<$Res> implements $SizeCopyWith<$Res> {
  factory _$SizeCopyWith(_Size value, $Res Function(_Size) then) =
      __$SizeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'key') String key,
      @JsonKey(name: 'value', defaultValue: false) bool value,
      @JsonKey(name: 'info') String info});
}

/// @nodoc
class __$SizeCopyWithImpl<$Res> extends _$SizeCopyWithImpl<$Res>
    implements _$SizeCopyWith<$Res> {
  __$SizeCopyWithImpl(_Size _value, $Res Function(_Size) _then)
      : super(_value, (v) => _then(v as _Size));

  @override
  _Size get _value => super._value as _Size;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
    Object info = freezed,
  }) {
    return _then(_Size(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as bool,
      info: info == freezed ? _value.info : info as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Size implements _Size {
  _$_Size(
      {@JsonKey(name: 'key') this.key,
      @JsonKey(name: 'value', defaultValue: false) this.value,
      @JsonKey(name: 'info') this.info});

  factory _$_Size.fromJson(Map<String, dynamic> json) =>
      _$_$_SizeFromJson(json);

  @override
  @JsonKey(name: 'key')
  final String key;
  @override
  @JsonKey(name: 'value', defaultValue: false)
  final bool value;
  @override
  @JsonKey(name: 'info')
  final String info;

  @override
  String toString() {
    return 'Size(key: $key, value: $value, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Size &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(info);

  @override
  _$SizeCopyWith<_Size> get copyWith =>
      __$SizeCopyWithImpl<_Size>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SizeToJson(this);
  }
}

abstract class _Size implements Size {
  factory _Size(
      {@JsonKey(name: 'key') String key,
      @JsonKey(name: 'value', defaultValue: false) bool value,
      @JsonKey(name: 'info') String info}) = _$_Size;

  factory _Size.fromJson(Map<String, dynamic> json) = _$_Size.fromJson;

  @override
  @JsonKey(name: 'key')
  String get key;
  @override
  @JsonKey(name: 'value', defaultValue: false)
  bool get value;
  @override
  @JsonKey(name: 'info')
  String get info;
  @override
  _$SizeCopyWith<_Size> get copyWith;
}

Price _$PriceFromJson(Map<String, dynamic> json) {
  return _Price.fromJson(json);
}

/// @nodoc
class _$PriceTearOff {
  const _$PriceTearOff();

// ignore: unused_element
  _Price call(
      {@JsonKey(name: 'listed_price') String listedPrice,
      @JsonKey(name: 'sale_price') String salePrice}) {
    return _Price(
      listedPrice: listedPrice,
      salePrice: salePrice,
    );
  }

// ignore: unused_element
  Price fromJson(Map<String, Object> json) {
    return Price.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Price = _$PriceTearOff();

/// @nodoc
mixin _$Price {
  @JsonKey(name: 'listed_price')
  String get listedPrice;
  @JsonKey(name: 'sale_price')
  String get salePrice;

  Map<String, dynamic> toJson();
  $PriceCopyWith<Price> get copyWith;
}

/// @nodoc
abstract class $PriceCopyWith<$Res> {
  factory $PriceCopyWith(Price value, $Res Function(Price) then) =
      _$PriceCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'listed_price') String listedPrice,
      @JsonKey(name: 'sale_price') String salePrice});
}

/// @nodoc
class _$PriceCopyWithImpl<$Res> implements $PriceCopyWith<$Res> {
  _$PriceCopyWithImpl(this._value, this._then);

  final Price _value;
  // ignore: unused_field
  final $Res Function(Price) _then;

  @override
  $Res call({
    Object listedPrice = freezed,
    Object salePrice = freezed,
  }) {
    return _then(_value.copyWith(
      listedPrice:
          listedPrice == freezed ? _value.listedPrice : listedPrice as String,
      salePrice: salePrice == freezed ? _value.salePrice : salePrice as String,
    ));
  }
}

/// @nodoc
abstract class _$PriceCopyWith<$Res> implements $PriceCopyWith<$Res> {
  factory _$PriceCopyWith(_Price value, $Res Function(_Price) then) =
      __$PriceCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'listed_price') String listedPrice,
      @JsonKey(name: 'sale_price') String salePrice});
}

/// @nodoc
class __$PriceCopyWithImpl<$Res> extends _$PriceCopyWithImpl<$Res>
    implements _$PriceCopyWith<$Res> {
  __$PriceCopyWithImpl(_Price _value, $Res Function(_Price) _then)
      : super(_value, (v) => _then(v as _Price));

  @override
  _Price get _value => super._value as _Price;

  @override
  $Res call({
    Object listedPrice = freezed,
    Object salePrice = freezed,
  }) {
    return _then(_Price(
      listedPrice:
          listedPrice == freezed ? _value.listedPrice : listedPrice as String,
      salePrice: salePrice == freezed ? _value.salePrice : salePrice as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Price implements _Price {
  _$_Price(
      {@JsonKey(name: 'listed_price') this.listedPrice,
      @JsonKey(name: 'sale_price') this.salePrice});

  factory _$_Price.fromJson(Map<String, dynamic> json) =>
      _$_$_PriceFromJson(json);

  @override
  @JsonKey(name: 'listed_price')
  final String listedPrice;
  @override
  @JsonKey(name: 'sale_price')
  final String salePrice;

  @override
  String toString() {
    return 'Price(listedPrice: $listedPrice, salePrice: $salePrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Price &&
            (identical(other.listedPrice, listedPrice) ||
                const DeepCollectionEquality()
                    .equals(other.listedPrice, listedPrice)) &&
            (identical(other.salePrice, salePrice) ||
                const DeepCollectionEquality()
                    .equals(other.salePrice, salePrice)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(listedPrice) ^
      const DeepCollectionEquality().hash(salePrice);

  @override
  _$PriceCopyWith<_Price> get copyWith =>
      __$PriceCopyWithImpl<_Price>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PriceToJson(this);
  }
}

abstract class _Price implements Price {
  factory _Price(
      {@JsonKey(name: 'listed_price') String listedPrice,
      @JsonKey(name: 'sale_price') String salePrice}) = _$_Price;

  factory _Price.fromJson(Map<String, dynamic> json) = _$_Price.fromJson;

  @override
  @JsonKey(name: 'listed_price')
  String get listedPrice;
  @override
  @JsonKey(name: 'sale_price')
  String get salePrice;
  @override
  _$PriceCopyWith<_Price> get copyWith;
}
