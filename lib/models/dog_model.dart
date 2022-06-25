class DogModel {
  DogModel._(this.image);
  final String image;

  factory DogModel.fromJson(Map<String, dynamic> data) =>
      DogModel._(data['message'].toString());
}
