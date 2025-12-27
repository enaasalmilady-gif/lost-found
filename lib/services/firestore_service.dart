import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lost_item.dart';

class FirestoreService {
  final CollectionReference _itemsCollection = FirebaseFirestore.instance
      .collection('items');

  // جلب جميع المفقودات بترتيب تنازلي حسب التاريخ
  Stream<List<LostItem>> getItems() {
    return _itemsCollection.orderBy('date', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LostItem(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          date: (data['date'] as Timestamp).toDate(),
          userId: data['userId'] ?? '',
          location: data['location'] ?? '',
          userName: data['userName'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();
    });
  }

  // إضافة غرض جديد
  Future<void> addItem(LostItem item) async {
    await _itemsCollection.add({
      'name': item.name,
      'description': item.description,
      'date': Timestamp.fromDate(item.date),
      'userId': item.userId,
      'location': item.location,
      'userName': item.userName,
      'phoneNumber': item.phoneNumber,
      'imageUrl': item.imageUrl,
    });
  }

  // حذف غرض
  Future<void> deleteItem(String id) async {
    await _itemsCollection.doc(id).delete();
  }
}
