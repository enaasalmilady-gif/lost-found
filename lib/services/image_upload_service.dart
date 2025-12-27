import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploadService {
  // مفتاح API الخاص بالمستخدم لخدمة ImgBB
  static const String _apiKey = "cac30d86af6cd6f42575e84e0e3f40f7";

  Future<String?> uploadImage(File imageFile) async {
    final url = Uri.parse('https://api.imgbb.com/1/upload?key=$_apiKey');

    try {
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonResponse = jsonDecode(responseString);

      if (response.statusCode == 200 && jsonResponse['data'] != null) {
        // نأخذ الرابط المباشر للصورة (url)
        return jsonResponse['data']['url'];
      } else {
        print('ImgBB Error: ${jsonResponse['error']['message']}');
        throw 'فشل الرفع إلى ImgBB: ${jsonResponse['error']['message']}';
      }
    } catch (e) {
      print('General Upload Error: $e');
      throw 'حدث خطأ أثناء الرفع: $e';
    }
  }
}
