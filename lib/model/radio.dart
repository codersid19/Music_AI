import 'dart:convert';

import 'package:collection/collection.dart';

class MyRadioList {
  final List<MyRadio> radios;
  MyRadioList({
    required this.radios,
  });

  MyRadioList copyWith({
    List<MyRadio>? radios,
  }) {
    return MyRadioList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    return MyRadioList(
      radios: List<MyRadio>.from(map['radios']?.map((x) => MyRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) => MyRadioList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is MyRadioList &&
      listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
  final int id;
  final int order;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String icon;
  final String image;
  final String lang;
  final String category;
  final String name;
  MyRadio({
    required this.id,
    required this.order,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.icon,
    required this.image,
    required this.lang,
    required this.category,
    required this.name,
  });


  MyRadio copyWith({
    int? id,
    int? order,
    String? tagline,
    String? color,
    String? desc,
    String? url,
    String? icon,
    String? image,
    String? lang,
    String? category,
    String? name,
  }) {
    return MyRadio(
      id: id ?? this.id,
      order: order ?? this.order,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
      category: category ?? this.category,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'icon': icon,
      'image': image,
      'lang': lang,
      'category': category,
      'name': name,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    return MyRadio(
      id: map['id'],
      order: map['order'],
      tagline: map['tagline'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
      category: map['category'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) => MyRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRadio(id: $id, order: $order, tagline: $tagline, color: $color, desc: $desc, url: $url, icon: $icon, image: $image, lang: $lang, category: $category, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyRadio &&
      other.id == id &&
      other.order == order &&
      other.tagline == tagline &&
      other.color == color &&
      other.desc == desc &&
      other.url == url &&
      other.icon == icon &&
      other.image == image &&
      other.lang == lang &&
      other.category == category &&
      other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      order.hashCode ^
      tagline.hashCode ^
      color.hashCode ^
      desc.hashCode ^
      url.hashCode ^
      icon.hashCode ^
      image.hashCode ^
      lang.hashCode ^
      category.hashCode ^
      name.hashCode;
  }
}

