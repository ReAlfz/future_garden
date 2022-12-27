class DataItem {
  String title, images, description, rating;
  String material, size, color, item;
  int price;

  DataItem({
    required this.title,
    required this.images,
    required this.price,
    required this.rating,
    required this.size,
    required this.color,
    required this.description,
    required this.material,
    required this.item
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
    title: json['title'],
    images: json['image'],
    price: json['price'],
    rating: json['rating'],
    size: json['size'],
    color: json['color'],
    description: json['description'],
    material: json['material'],
    item: json['item']
  );
}

class HeadList {
  List<DataItem> list_item;
  List<DataItem> list_room;

  HeadList({
    required this.list_item,
    required this.list_room
  });

  factory HeadList.fromJson(Map<String, dynamic> json) => HeadList(
    list_item: List<DataItem>.from(json['list_item'].map((element) => DataItem.fromJson(element))).toList(),
    list_room: List<DataItem>.from(json['list_pack'].map((element) => DataItem.fromJson(element))).toList(),
  );
}