from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional

@dataclass
class Rahatsizlik:
    id: Optional[int] = None
    isim: str = ""
    aciklama: str = ""
    belirtiler: str = ""
    risk_faktorleri: str = ""
    onlemler: str = ""
    etiketler: List[str] = None
    seviye: str = "orta"
    yayginlik: str = "orta"
    olusturulma_tarihi: datetime = None
    guncellenme_tarihi: datetime = None

    def __post_init__(self):
        if self.etiketler is None:
            self.etiketler = []
        if self.olusturulma_tarihi is None:
            self.olusturulma_tarihi = datetime.now()
        if self.guncellenme_tarihi is None:
            self.guncellenme_tarihi = datetime.now()

@dataclass
class Bitki:
    id: Optional[int] = None
    isim: str = ""
    tip: str = ""
    resim: Optional[str] = None
    faydalar: str = ""
    kullanim: str = ""
    hazirlama: str = ""
    uyarilar: str = ""
    doz: str = ""
    etiketler: List[str] = None
    mevsim: List[str] = None
    yan_etkiler: List[str] = None
    kontrendikasyonlar: List[str] = None
    saklama_kosullari: str = ""
    raf_omru: str = ""
    kaynak: str = ""
    bilimsel_ad: str = ""
    aile: str = ""
    cins: str = ""
    tur: str = ""
    olusturulma_tarihi: datetime = None
    guncellenme_tarihi: datetime = None
    rahatsizliklar: List[int] = None

    def __post_init__(self):
        if self.etiketler is None:
            self.etiketler = []
        if self.mevsim is None:
            self.mevsim = []
        if self.yan_etkiler is None:
            self.yan_etkiler = []
        if self.kontrendikasyonlar is None:
            self.kontrendikasyonlar = []
        if self.rahatsizliklar is None:
            self.rahatsizliklar = []
        if self.olusturulma_tarihi is None:
            self.olusturulma_tarihi = datetime.now()
        if self.guncellenme_tarihi is None:
            self.guncellenme_tarihi = datetime.now() 