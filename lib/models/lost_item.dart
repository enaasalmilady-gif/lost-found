// lib/models/lost_item.dart

/// موديل يمثل الغرض المفقود
/// يحتوي على كل البيانات الخاصة بالغرض الواحد
class LostItem {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String userId;
  final String location;
  final String userName;
  final String phoneNumber;
  final String imageUrl;

  LostItem({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.userId,
    required this.location,
    required this.userName,
    required this.phoneNumber,
    this.imageUrl = 'https://via.placeholder.com/150', // صورة افتراضية
  });
}
