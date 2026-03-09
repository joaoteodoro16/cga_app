abstract class BaseSearchFilterItem {
  final String label;
  final String key;

  const BaseSearchFilterItem({
    required this.label,
    required this.key,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseSearchFilterItem && key == other.key;

  @override
  int get hashCode => key.hashCode;
}