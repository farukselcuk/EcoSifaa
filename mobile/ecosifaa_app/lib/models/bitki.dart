class Bitki {
  final int id;
  final String ad;
  final String bilimselAd;
  final String tip;
  final String resimUrl;
  final String aciklama;
  final List<String> faydalar;
  final List<String> kullanimAlanlari;
  final List<String> uyarilar;

  Bitki({
    required this.id,
    required this.ad,
    required this.bilimselAd,
    required this.tip,
    required this.resimUrl,
    required this.aciklama,
    required this.faydalar,
    required this.kullanimAlanlari,
    required this.uyarilar,
  });

  factory Bitki.fromJson(Map<String, dynamic> json) {
    return Bitki(
      id: json['id'] as int,
      ad: json['ad'] as String,
      bilimselAd: json['bilimsel_ad'] as String,
      tip: json['tip'] as String,
      resimUrl: json['resim_url'] as String,
      aciklama: json['aciklama'] as String,
      faydalar: List<String>.from(json['faydalar'] as List),
      kullanimAlanlari: List<String>.from(json['kullanim_alanlari'] as List),
      uyarilar: List<String>.from(json['uyarilar'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ad': ad,
      'bilimsel_ad': bilimselAd,
      'tip': tip,
      'resim_url': resimUrl,
      'aciklama': aciklama,
      'faydalar': faydalar,
      'kullanim_alanlari': kullanimAlanlari,
      'uyarilar': uyarilar,
    };
  }
} 