from typing import List, Optional
from sifalibitkiler.domain.entities import Bitki, Rahatsizlik
from sifalibitkiler.domain.repositories import BitkiRepository, RahatsizlikRepository

class BitkiService:
    def __init__(self, bitki_repository: BitkiRepository):
        self.bitki_repository = bitki_repository

    def get_bitki(self, bitki_id: int) -> Optional[Bitki]:
        return self.bitki_repository.get_by_id(bitki_id)

    def get_all_bitkiler(self) -> List[Bitki]:
        return self.bitki_repository.get_all()

    def create_bitki(self, bitki: Bitki) -> Bitki:
        return self.bitki_repository.create(bitki)

    def update_bitki(self, bitki: Bitki) -> Bitki:
        return self.bitki_repository.update(bitki)

    def delete_bitki(self, bitki_id: int) -> bool:
        return self.bitki_repository.delete(bitki_id)

    def search_bitkiler(self, name: str) -> List[Bitki]:
        return self.bitki_repository.search_by_name(name)

    def get_bitkiler_by_rahatsizlik(self, rahatsizlik_id: int) -> List[Bitki]:
        return self.bitki_repository.get_by_rahatsizlik(rahatsizlik_id)

class RahatsizlikService:
    def __init__(self, rahatsizlik_repository: RahatsizlikRepository):
        self.rahatsizlik_repository = rahatsizlik_repository

    def get_rahatsizlik(self, rahatsizlik_id: int) -> Optional[Rahatsizlik]:
        return self.rahatsizlik_repository.get_by_id(rahatsizlik_id)

    def get_all_rahatsizliklar(self) -> List[Rahatsizlik]:
        return self.rahatsizlik_repository.get_all()

    def create_rahatsizlik(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        return self.rahatsizlik_repository.create(rahatsizlik)

    def update_rahatsizlik(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        return self.rahatsizlik_repository.update(rahatsizlik)

    def delete_rahatsizlik(self, rahatsizlik_id: int) -> bool:
        return self.rahatsizlik_repository.delete(rahatsizlik_id)

    def search_rahatsizliklar(self, name: str) -> List[Rahatsizlik]:
        return self.rahatsizlik_repository.search_by_name(name) 