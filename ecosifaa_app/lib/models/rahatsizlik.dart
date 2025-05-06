class Rahatsizlik {
  final int id;
  final String ad;
  final String aciklama;

  Rahatsizlik({
    required this.id,
    required this.ad,
    required this.aciklama,
  });

  factory Rahatsizlik.fromJson(Map<String, dynamic> json) {
    return Rahatsizlik(
      id: json['id'],
      ad: json['ad'],
      aciklama: json['aciklama'],
    );
  }
} 