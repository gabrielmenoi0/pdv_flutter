class NavigateException<T> implements Exception {

  NavigateException(this.model);
  final dynamic model;

  @override
  String toString() {
    return 'This model variable doesn`t found in route $model and $T!';
  }
}
