class AvaliableDogModel {
  final List<String> data;
  AvaliableDogModel._(this.data);

  factory AvaliableDogModel.fromJson(Map<String, dynamic> data) {
    final List<String> _data = [];
    final Map _message = data['message'] as Map;
    _message.forEach((key, value) {
      _data.add(key.toString());
    });
    return AvaliableDogModel._(_data);
  }
}
