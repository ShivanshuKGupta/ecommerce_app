import 'package:ecommerce_app/models/firestore/firestore_collection.dart';
import 'package:ecommerce_app/models/firestore/firestore_document.dart';

class Product extends FirestoreDocument {
  String? imgUrl;
  String? name;
  double price = 0;
  String? description;
  String? category;
  String? brand;
  bool? isFeatured;
  bool? isPopular;

  Product({
    super.id,
    this.imgUrl,
    this.name,
    this.price = 0,
    this.description,
    this.category,
    this.brand,
    this.isFeatured,
    this.isPopular,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['imgUrl'] = imgUrl;
    json['name'] = name;
    json['price'] = price;
    json['description'] = description;
    json['category'] = category;
    json['brand'] = brand;

    json['isFeatured'] = isFeatured;
    json['isPopular'] = isPopular;
    return json;
  }

  void loadFromJson(Map<String, dynamic> json) {
    id = json['id'] ?? id;
    imgUrl = json['imgUrl'];
    name = json['name'];
    price = (json['price'] ?? 0).toDouble();
    description = json['description'];
    category = json['category'];
    brand = json['brand'];

    isFeatured = json['isFeatured'];
    isPopular = json['isPopular'];
  }

  @override
  Future<Product> fetch() async {
    super.path = FirestoreCollection.products;
    await super.fetch();
    loadFromJson(super.data);
    return this;
  }

  @override
  Future<void> update() async {
    super.path = FirestoreCollection.products;
    super.data = toJson();
    return super.update();
  }
}

Future<List<Product>> fetchProducts(
    {String? start, int? limit, String? orderBy, bool? descending}) async {
  final products =
      await FirestoreCollection(id: FirestoreCollection.products).get(
    start: start,
    limit: limit,
    orderBy: orderBy,
    descending: descending,
  );
  return products.map((e) => Product(id: e.id)..loadFromJson(e.data)).toList();
}
