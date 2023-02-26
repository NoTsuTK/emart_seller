import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';

class StoreService {
  static getProfile(uid) {
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(productionCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }
}
