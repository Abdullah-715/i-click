import 'pagenation_model.dart';

class DataModel<T> {
  final T data;
  final PagenationModel pagenation;

  DataModel({required this.data, required this.pagenation});
}