import React from 'react';

const menu = [
  { label: 'Dashboard', tab: 'dashboard' },
  { label: 'Bitkiler', tab: 'plants' },
  { label: 'Karışımlar', tab: 'mixtures' },
  { label: 'Kullanıcılar', tab: 'users' },
  { label: 'Ayarlar', tab: 'settings' },
];

interface AdminHeaderProps {
  activeTab: string;
  setActiveTab: (tab: string) => void;
}

const AdminHeader: React.FC<AdminHeaderProps> = ({ activeTab, setActiveTab }) => {
  return (
    <header className="w-full bg-green-600 text-white flex items-center justify-between px-8 py-4 shadow">
      <div className="flex items-center gap-3">
        <span className="font-bold text-2xl">🌿 AlternatifTıp</span>
        <span className="text-sm opacity-80 hidden sm:inline">Admin Paneli</span>
      </div>
      <nav className="flex gap-4">
        {menu.map((item) => (
          <button
            key={item.tab}
            onClick={() => setActiveTab(item.tab)}
            className={`px-4 py-2 rounded transition ${
              activeTab === item.tab
                ? 'bg-green-800 font-semibold'
                : 'hover:bg-green-700'
            }`}
          >
            {item.label}
          </button>
        ))}
      </nav>
      <div className="flex items-center gap-3">
        <div className="w-9 h-9 rounded-full bg-white text-green-600 flex items-center justify-center font-bold">A</div>
        <button className="bg-green-800 px-3 py-1 rounded text-white hover:bg-green-900 transition">Çıkış</button>
      </div>
    </header>
  );
};

export default AdminHeader; 