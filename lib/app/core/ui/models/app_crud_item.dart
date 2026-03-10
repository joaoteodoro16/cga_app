class AppCrudItem<T> {
  final String title;
  final String? subtitle;
  final String? secondSubtitle;
  final T data;
  final bool active;

  AppCrudItem({
    required this.title,
    this.subtitle,
    required this.active,
    required this.data, this.secondSubtitle,
  });
}
