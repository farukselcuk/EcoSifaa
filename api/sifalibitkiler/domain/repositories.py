from abc import ABC, abstractmethod
from typing import List, Optional
from .entities import Bitki, Rahatsizlik

class BitkiRepository(ABC):
    @abstractmethod
    def get_by_id(self, bitki_id: int) -> Optional[Bitki]:
        pass

    @abstractmethod
    def get_all(self) -> List[Bitki]:
        pass

    @abstractmethod
    def create(self, bitki: Bitki) -> Bitki:
        pass

    @abstractmethod
    def update(self, bitki: Bitki) -> Bitki:
        pass

    @abstractmethod
    def delete(self, bitki_id: int) -> bool:
        pass

    @abstractmethod
    def search_by_name(self, name: str) -> List[Bitki]:
        pass

    @abstractmethod
    def get_by_rahatsizlik(self, rahatsizlik_id: int) -> List[Bitki]:
        pass

class RahatsizlikRepository(ABC):
    @abstractmethod
    def get_by_id(self, rahatsizlik_id: int) -> Optional[Rahatsizlik]:
        pass

    @abstractmethod
    def get_all(self) -> List[Rahatsizlik]:
        pass

    @abstractmethod
    def create(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        pass

    @abstractmethod
    def update(self, rahatsizlik: Rahatsizlik) -> Rahatsizlik:
        pass

    @abstractmethod
    def delete(self, rahatsizlik_id: int) -> bool:
        pass

    @abstractmethod
    def search_by_name(self, name: str) -> List[Rahatsizlik]:
        pass 