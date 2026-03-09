class AppCrudItem<T> {
  final String title;
  final String? subtitle;
  final T data;
  final bool active;

  AppCrudItem({
    required this.title,
    this.subtitle,
    required this.active,
    required this.data,
  });
}
