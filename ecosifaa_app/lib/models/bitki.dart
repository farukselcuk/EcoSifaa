class Bitki {
  final int id;
  final String ad;
  final String bilimselAd;
  final String aciklama;
  final String resimUrl;

  Bitki({
    required this.id,
    required this.ad,
    required this.bilimselAd,
    required this.aciklama,
    required this.resimUrl,
  });

  factory Bitki.fromJson(Map<String, dynamic> json) {
    return Bitki(
      id: json['id'],
      ad: json['ad'],
      bilimselAd: json['bilimsel_ad'],
      aciklama: json['aciklama'],
      resimUrl: json['resim_url'] ?? '',
    );
  }
} 