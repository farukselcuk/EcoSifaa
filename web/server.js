// EcoSifaa Yerel Sunucu
// Bu dosya web klasöründeki dosyaları localhost üzerinden servis etmek için kullanılır

const express = require('express');
const path = require('path');
const app = express();
const port = 8080;
const session = require('express-session');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;

// Statik dosyaları servis et
app.use(express.static(__dirname));

// Oturum yönetimi
app.use(session({
  secret: 'ecosifaa_secret_key', // Güçlü bir secret ile değiştirin
  resave: false,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());

// Kullanıcı serialize/deserialize
passport.serializeUser((user, done) => {
  done(null, user);
});
passport.deserializeUser((user, done) => {
  done(null, user);
});

// Google OAuth ayarları (ClientID/Secret'ı kendi bilgilerinizle değiştirin)
passport.use(new GoogleStrategy({
  clientID: 'GOOGLE_CLIENT_ID', // <-- Buraya kendi clientID'nizi girin
  clientSecret: 'GOOGLE_CLIENT_SECRET', // <-- Buraya kendi clientSecret'ınızı girin
  callbackURL: '/auth/google/callback'
}, (accessToken, refreshToken, profile, done) => {
  // Admin kontrolü için e-posta adresi kontrolü yapılabilir
  const adminEmails = ['admin@ecosifaa.com']; // Admin e-posta adreslerini buraya ekleyin
  const isAdmin = profile.emails && profile.emails[0] && adminEmails.includes(profile.emails[0].value);
  const user = {
    id: profile.id,
    displayName: profile.displayName,
    email: profile.emails[0].value,
    photo: profile.photos[0].value,
    isAdmin
  };
  return done(null, user);
}));

// Google ile giriş başlat
app.get('/auth/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// Google callback
app.get('/auth/google/callback', passport.authenticate('google', {
  failureRedirect: '/?login=fail'
}), (req, res) => {
  // Başarılı girişten sonra ana sayfaya yönlendir
  res.redirect('/');
});

// Çıkış
app.get('/logout', (req, res) => {
  req.logout(() => {
    res.redirect('/');
  });
});

// Ana sayfa yönlendirmesi
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Kullanıcı bilgilerini döndür
app.get('/api/user', (req, res) => {
    if (req.isAuthenticated()) {
        res.json({
            isAuthenticated: true,
            user: {
                id: req.user.id,
                displayName: req.user.displayName,
                email: req.user.email,
                photo: req.user.photo,
                isAdmin: req.user.isAdmin
            }
        });
    } else {
        res.json({ isAuthenticated: false });
    }
});

// Admin paneli için yetkilendirme kontrolü
app.get('/admin', isAuthenticated, isAdmin, (req, res) => {
    res.sendFile(path.join(__dirname, 'admin-panel.html'));
});

// Yetkilendirme middleware'leri
function isAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        return next();
    }
    res.redirect('/');
}

function isAdmin(req, res, next) {
    if (req.user && req.user.isAdmin) {
        return next();
    }
    res.redirect('/');
}

// 404 sayfası
app.use((req, res) => {
  res.status(404).sendFile(path.join(__dirname, 'offline.html'));
});

// Sunucuyu başlat
app.listen(port, () => {
  console.log(`
  =========================================
  |                                       |
  |  EcoSifaa Web Sunucusu                |
  |  Sunucu başlatıldı!                   |
  |                                       |
  |  URL: http://localhost:${port}          |
  |  Admin: http://localhost:${port}/admin  |
  |                                       |
  |  Ctrl+C ile kapatabilirsiniz          |
  |                                       |
  =========================================
  `);
}); 