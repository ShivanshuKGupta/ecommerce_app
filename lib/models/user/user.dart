import 'package:ecommerce_app/models/firestore/firestore_collection.dart';
import 'package:ecommerce_app/models/firestore/firestore_document.dart';
import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/models/products/product.dart';

class UserData extends FirestoreDocument {
  // The email and firestore id are the same for any user
  String get email {
    return super.id;
  }

  String? name;
  String? phoneNumber;
  String? address;
  String? imgUrl;
  String? role;
  List<String>? favorites;
  List<String>? shopping;
  List<String>? saved;

  UserData({
    super.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.imgUrl,
    this.role,
  }) : super(path: FirestoreCollection.users);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name;
    json['phoneNumber'] = phoneNumber;
    json['address'] = address;
    json['imgUrl'] = imgUrl;
    json['role'] = role;
    return json;
  }

  void loadFromJson(Map<String, dynamic> json) {
    id = json['email'] ?? json['id'] ?? id;
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    imgUrl = json['imgUrl'];
    role = json['role'];
  }

  @override
  Future<void> fetch() async {
    super.path = FirestoreCollection.users;
    await super.fetch();
    await getCartData();
    loadFromJson(super.data);
  }

  @override
  Future<void> update() async {
    super.path = FirestoreCollection.users;
    super.data = toJson();
    return super.update();
  }

  Future<FirestoreDocument> getCartData() async {
    final cartData =
        FirestoreDocument(path: FirestoreCollection.cart, id: currentUser.id);
    await cartData.fetch();
    favorites = cartData.data['favorites'] == null
        ? []
        : (cartData.data['favorites'] as List<dynamic>)
            .map((e) => e.toString())
            .toList();
    shopping = cartData.data['shopping'] == null
        ? []
        : (cartData.data['shopping'] as List<dynamic>)
            .map((e) => e.toString())
            .toList();
    saved = cartData.data['saved'] == null
        ? []
        : (cartData.data['saved'] as List<dynamic>)
            .map((e) => e.toString())
            .toList();
    return cartData;
  }

  Future<List<Product>> fetchShoppingProducts() async {
    final cartData = await getCartData();
    final List<Future<Product>> productFutures = shopping!.map((productID) {
      final product = Product(id: productID);
      return product.fetch();
      // return product;
    }).toList();
    final List<Product> products = await Future.wait(productFutures);
    return products;
  }

  Future<void> updateCartData() async {
    final cartData =
        FirestoreDocument(path: FirestoreCollection.cart, id: currentUser.id);
    cartData.data['favorites'] = favorites;
    cartData.data['shopping'] = shopping;
    cartData.data['saved'] = saved;
    await cartData.update();
  }

  Future<void> addRemoveToCart(String productID) async {
    final cartData = await getCartData();
    if (!shopping!.contains(productID)) {
      shopping!.add(productID);
    } else {
      shopping!.remove(productID);
    }
    await updateCartData();
  }

  Future<void> addRemoveToSaved(String productID) async {
    final cartData = await getCartData();
    if (!saved!.contains(productID)) {
      saved!.add(productID);
    } else {
      saved!.remove(productID);
    }
    await updateCartData();
  }

  Future<void> addRemoveToFavorites(String productID) async {
    final cartData = await getCartData();
    if (!favorites!.contains(productID)) {
      favorites!.add(productID);
    } else {
      favorites!.remove(productID);
    }
    await updateCartData();
  }
}
