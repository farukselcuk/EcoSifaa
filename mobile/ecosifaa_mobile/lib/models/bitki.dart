class Bitki {
  final int id;
  final String isim;
  final String tip;
  final String? resimUrl;
  final List<String> rahatsizliklar;
  final String? bilimselAd;
  final String? faydalar;
  final String? kullanim;
  final String? hazirlama;
  final String? uyarilar;
  final List<String>? etiketler;
  final DateTime olusturmaTarihi;
  final DateTime guncellenmeTarihi;

  Bitki({
    required this.id,
    required this.isim,
    required this.tip,
    this.resimUrl,
    required this.rahatsizliklar,
    this.bilimselAd,
    this.faydalar,
    this.kullanim,
    this.hazirlama,
    this.uyarilar,
    this.etiketler,
    required this.olusturmaTarihi,
    required this.guncellenmeTarihi,
  });

  factory Bitki.fromJson(Map<String, dynamic> json) {
    return Bitki(
      id: json['id'],
      isim: json['isim'],
      tip: json['tip'],
      resimUrl: json['resim'],
      rahatsizliklar: List<String>.from(json['rahatsizliklar_isimleri'] ?? []),
      bilimselAd: json['bilimsel_ad'],
      faydalar: json['faydalar'],
      kullanim: json['kullanim'],
      hazirlama: json['hazirlama'],
      uyarilar: json['uyarilar'],
      etiketler: json['etiketler_list'] != null 
          ? List<String>.from(json['etiketler_list']) 
          : null,
      olusturmaTarihi: DateTime.parse(json['olusturulma_tarihi']),
      guncellenmeTarihi: DateTime.parse(json['guncellenme_tarihi']),
    );
  }
} 