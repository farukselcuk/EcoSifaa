class Rahatsizlik {
  final int id;
  final String isim;
  final String aciklama;
  final String? belirtiler;
  final String? riskFaktorleri;
  final String? onlemler;

  Rahatsizlik({
    required this.id,
    required this.isim,
    required this.aciklama,
    this.belirtiler,
    this.riskFaktorleri,
    this.onlemler,
  });

  factory Rahatsizlik.fromJson(Map<String, dynamic> json) {
    return Rahatsizlik(
      id: json['id'],
      isim: json['isim'],
      aciklama: json['aciklama'] ?? '',
      belirtiler: json['belirtiler'],
      riskFaktorleri: json['risk_faktorleri'],
      onlemler: json['onlemler'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isim': isim,
      'aciklama': aciklama,
      'belirtiler': belirtiler,
      'risk_faktorleri': riskFaktorleri,
      'onlemler': onlemler,
    };
  }
} 