class RuqyahEntity {
  final int id;
  final int order;
  final String zikr;
  final int count;
  final String source;
  final bool almujaza;
  final bool almutawasita;
  final bool almutawala;

  RuqyahEntity({
    required this.id,
    required this.order,
    required this.zikr,
    required this.count,
    required this.source,
    required this.almujaza,
    required this.almutawasita,
    required this.almutawala,
  });
}
