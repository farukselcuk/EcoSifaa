class Rahatsizlik {
  final int id;
  final String ad;
  final String aciklama;
  final List<String> belirtiler;
  final List<String> riskFaktorleri;
  final List<String> onlemler;
  final List<int> onerilenBitkiler;

  Rahatsizlik({
    required this.id,
    required this.ad,
    required this.aciklama,
    required this.belirtiler,
    required this.riskFaktorleri,
    required this.onlemler,
    required this.onerilenBitkiler,
  });

  factory Rahatsizlik.fromJson(Map<String, dynamic> json) {
    return Rahatsizlik(
      id: json['id'] as int,
      ad: json['ad'] as String,
      aciklama: json['aciklama'] as String,
      belirtiler: List<String>.from(json['belirtiler'] as List),
      riskFaktorleri: List<String>.from(json['risk_faktorleri'] as List),
      onlemler: List<String>.from(json['onlemler'] as List),
      onerilenBitkiler: List<int>.from(json['onerilen_bitkiler'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ad': ad,
      'aciklama': aciklama,
      'belirtiler': belirtiler,
      'risk_faktorleri': riskFaktorleri,
      'onlemler': onlemler,
      'onerilen_bitkiler': onerilenBitkiler,
    };
  }
} 