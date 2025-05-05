from typing import List, Optional
from django.db.models import Q
from sifalibitkiler.domain.entities import Bitki, Rahatsizlik
from sifalibitkiler.domain.repositories import BitkiRepository, RahatsizlikRepository
from sifalibitkiler.models import Bitki as BitkiModel, Rahatsizlik as RahatsizlikModel

class DjangoBitkiRepository(BitkiRepository):
    def get_by_id(self, bitki_id: int) -> Optional[Bitki]:
        try:
            bitki_model = BitkiModel.objects.get(id=bitki_id)
            return self._to_entity(bitki_model)
        except BitkiModel.DoesNotExist:
            return None

    def get_all(self) -> List[Bitki]:
        return [self._to_entity(bitki) for bitki in BitkiModel.objects.all()]

    def create(self, bitki: Bitki) -> Bitki:
        bitki_model = BitkiModel.objects.create(
            isim=bitki.isim,
            tip=bitki.tip,
            resim=bitki.resim,
            faydalar=bitki.faydalar,
            kullanim=bitki.kullanim,
            hazirlama=bitki.hazirlama,
            uyarilar=bitki.uyarilar,
            doz=bitki.doz,
            etiketler=', '.join(bitki.etiketler),
            mevsim=', '.join(bitki.mevsim),
            yan_etkiler=', '.join(bitki.yan_etkiler),
            kontrendikasyonlar=', '.join(bitki.kontrendikasyonlar),
            saklama_kosullari=bitki.saklama_kosullari,
            raf_omru=bitki.raf_omru,
            kaynak=bitki.kaynak,
            bilimsel_ad=bitki.bilimsel_ad,
            aile=bitki.aile,
            cins=bitki.cins,
            tur=bitki.tur
        )
        bitki_model.rahatsizliklar.set(bitki.rahatsizliklar)
        return self._to_entity(bitki_model)

    def update(self, bitki: Bitki) -> Bitki:
        bitki_model = BitkiModel.objects.get(id=bitki.id)
        bitki_model.isim = bitki.isim
        bitki_model.tip = bitki.tip
        bitki_model.resim = bitki.resim
        bitki_model.faydalar = bitki.faydalar
        bitki_model.kullanim = bitki.kullanim
        bitki_model.hazirlama = bitki.hazirlama
        bitki_model.uyarilar = bitki.uyarilar
        bitki_model.doz = bitki.doz
        bitki_model.etiketler = ', '.join(bitki.etiketler)
        bitki_model.mevsim = ', '.join(bitki.mevsim)
        bitki_model.yan_etkiler = ', '.join(bitki.yan_etkiler)
        bitki_model.kontrendikasyonlar = ', '.join(bitki.kontrendikasyonlar)
        bitki_model.saklama_kosullari = bitki.saklama_kosullari
        bitki_model.raf_omru = bitki.raf_omru
        bitki_model.kaynak = bitki.kaynak
        bitki_model.bilimsel_ad = bitki.bilimsel_ad
        bitki_model.aile = bitki.aile
        bitki_model.cins = bitki.cins
        bitki_model.tur = bitki.tur
        bitki_model.save()
        bitki_model.rahatsizliklar.set(bitki.rahatsizliklar)
        return self._to_entity(bitki_model)

    def delete(self, bitki_id: int) -> bool:
        try:
            BitkiModel.objects.get(id=bitki_id).delete()
            return True
        except BitkiModel.DoesNotExist:
            return False

    def search_by_name(self, name: str) -> List[Bitki]:
        bitkiler = BitkiModel.objects.filter(
            Q(isim__icontains=name) | 
            Q(bilimsel_ad__icontains=name)
        )
        return [self._to_entity(bitki) for bitki in bitkiler]

    def get_by_rahatsizlik(self, rahatsizlik_id: int) -> List[Bitki]:
        bitkiler = BitkiModel.objects.filter(rahatsizliklar__id=rahatsizlik_id)
        return [self._to_entity(bitki) for bitki in bitkiler]

    def _to_entity(self, bitki_model: BitkiModel) -> Bitki:
        return Bitki(
            id=bitki_model.id,
            isim=bitki_model.isim,
            tip=bitki_model.tip,
            resim=bitki_model.resim.url if bitki_model.resim else None,
            faydalar=bitki_model.faydalar,
            kullanim=bitki_model.kullanim,
            hazirlama=bitki_model.hazirlama,
            uyarilar=bitki_model.uyarilar,
            doz=bitki_model.doz,
            etiketler=bitki_model.get_etiketler_list(),
            mevsim=bitki_model.get_mevsim_list(),
            yan_etkiler=bitki_model.get_yan_etkiler_list(),
            kontrendikasyonlar=bitki_model.get_kontrendikasyonlar_list(),
            saklama_kosullari=bitki_model.saklama_kosullari,
            raf_omru=bitki_model.raf_omru,
            kaynak=bitki_model.kaynak,
            bilimsel_ad=bitki_model.bilimsel_ad,
            aile=bitki_model.aile,
            cins=bitki_model.cins,
            tur=bitki_model.tur,
            olusturulma_tarihi=bitki_model.olusturulma_tarihi,
            guncellenme_tarihi=bitki_model.guncellenme_tarihi,
            rahatsizliklar=list(bitki_model.rahatsizliklar.values_list('id', flat=True))
        )

class DjangoRahatsizlikRepository(RahatsizlikRepository):
    def get_by_id(self, rahatsizlik_id: int) -> Optional[Rahatsizlik]:
        try:
            rahatsizlik_model = RahatsizlikModel.objects.get(id=rahatsizlik_id)
            return self._to_entity(rahatsizlik_model)
        except RahatsizlikModel.DoesNotExist:
            return None

    def get_all(self) -> List[Rahatsizlik]:
        return [self._to_entity(rahatsizlik) for rahatsizlik in RahatsizlikModel.objects.all()]

    def create(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        rahatsizlik_model = RahatsizlikModel.objects.create(
            isim=rahatsizlik.isim,
            aciklama=rahatsizlik.aciklama,
            belirtiler=rahatsizlik.belirtiler,
            risk_faktorleri=rahatsizlik.risk_faktorleri,
            onlemler=rahatsizlik.onlemler,
            etiketler=', '.join(rahatsizlik.etiketler),
            seviye=rahatsizlik.seviye,
            yayginlik=rahatsizlik.yayginlik
        )
        return self._to_entity(rahatsizlik_model)

    def update(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        rahatsizlik_model = RahatsizlikModel.objects.get(id=rahatsizlik.id)
        rahatsizlik_model.isim = rahatsizlik.isim
        rahatsizlik_model.aciklama = rahatsizlik.aciklama
        rahatsizlik_model.belirtiler = rahatsizlik.belirtiler
        rahatsizlik_model.risk_faktorleri = rahatsizlik.risk_faktorleri
        rahatsizlik_model.onlemler = rahatsizlik.onlemler
        rahatsizlik_model.etiketler = ', '.join(rahatsizlik.etiketler)
        rahatsizlik_model.seviye = rahatsizlik.seviye
        rahatsizlik_model.yayginlik = rahatsizlik.yayginlik
        rahatsizlik_model.save()
        return self._to_entity(rahatsizlik_model)

    def delete(self, rahatsizlik_id: int) -> bool:
        try:
            RahatsizlikModel.objects.get(id=rahatsizlik_id).delete()
            return True
        except RahatsizlikModel.DoesNotExist:
            return False

    def search_by_name(self, name: str) -> List[Rahatsizlik]:
        rahatsizliklar = RahatsizlikModel.objects.filter(isim__icontains=name)
        return [self._to_entity(rahatsizlik) for rahatsizlik in rahatsizliklar]

    def _to_entity(self, rahatsizlik_model: RahatsizlikModel) -> Rahatsizlik:
        return Rahatsizlik(
            id=rahatsizlik_model.id,
            isim=rahatsizlik_model.isim,
            aciklama=rahatsizlik_model.aciklama,
            belirtiler=rahatsizlik_model.belirtiler,
            risk_faktorleri=rahatsizlik_model.risk_faktorleri,
            onlemler=rahatsizlik_model.onlemler,
            etiketler=rahatsizlik_model.get_etiketler_list(),
            seviye=rahatsizlik_model.seviye,
            yayginlik=rahatsizlik_model.yayginlik,
            olusturulma_tarihi=rahatsizlik_model.olusturulma_tarihi,
            guncellenme_tarihi=rahatsizlik_model.guncellenme_tarihi
        ) 