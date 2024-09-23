class SebhaZikrModel {
  final int id;
  final String zikr;
  final int count;

  SebhaZikrModel({
    required this.zikr,
    required this.count,
  }) : id = _generateUniqueId(zikr, count);

  // Private method to generate a unique ID based on zikr and count
  static int _generateUniqueId(String zikr, int count) {
    // Create a unique string based on zikr and count
    final uniqueString = '$zikr$count';

    // Use a hash function to generate a unique integer ID
    return uniqueString.hashCode;
  }

  // Convert a SebhaZikrModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zikr': zikr,
      'count': count,
    };
  }

  // Create a SebhaZikrModel instance from a map
  factory SebhaZikrModel.fromJson(Map<String, dynamic> json) {
    return SebhaZikrModel(
      zikr: json['zikr'],
      count: json['count'],
    );
  }
}
