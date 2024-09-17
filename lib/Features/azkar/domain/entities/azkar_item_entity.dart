class AzkarItemEntity {
  final int id;
  final String text;
  final int count;
  final String? source;

  AzkarItemEntity({
    required this.id,
    required this.text,
    required this.count,
    this.source,
  });
}
