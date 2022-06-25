import 'package:http/http.dart' as http;
import '/models/avaliabledog_model.dart';
import '../models/dog_model.dart';
import 'dart:convert';

class _Api {
  Future<Map<String, Object>?> get(String uri) async {
    try {
      final http.Response data = await http.get(Uri.parse(uri));
      return jsonDecode(data.body);
    } catch (e) {
      return null;
    }
  }
}

class ApiService extends _Api {
  AvaliableDogModel? avaliable;

  ApiService._() {
    avaliableDog().then((avaliableData) => avaliable = avaliableData);
  }
//Single Instance
  static ApiService? _instance;

  static ApiService instance() {
    _instance ??= ApiService._();
    return _instance!;
  }

  Future<AvaliableDogModel?> avaliableDog() async {
    final Map<String, dynamic>? _result =
        await get('https://dog.ceo/api/breeds/list/all');
    if (_result == null) return null;
    return AvaliableDogModel.fromJson(_result);
  }

  Future<DogModel?> getDog(String dog) async {
    final Map<String, dynamic>? _result =
        await get('https://dog.ceo/api/breeds/$dog/list/all');
    if (_result == null) return null;
    return DogModel.fromJson(_result);
  }
}
