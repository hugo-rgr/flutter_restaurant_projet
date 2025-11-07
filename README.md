# Application de Réservation de Restaurant (Flutter + API Node.js)

## 1. Description du projet
Cette application est une solution complète de réservation pour un restaurant fictif. Elle comprend:
- Une application mobile Flutter (front) permettant de consulter le menu, effectuer et gérer des réservations, visualiser la localisation du restaurant sur une carte Google Maps, et gérer le profil utilisateur.
- Une API backend Node.js/Express avec Prisma (PostgreSQL) gérant l'authentification, les utilisateurs, les tables et les réservations.

Objectif: fournir une base modulaire pour un système de gestion de réservations simple et extensible.

## 2. Technologies principales
Frontend (Flutter):
- Flutter 3.x (Dart)
- Riverpod (gestion d'état)
- Dio (HTTP)
- Google Maps (localisation) : interface faite mais intégration avec google maps incomplet
- Freezed (modèles immuables, partiel)
- Secure Storage (persistences locales)

Backend (Node.js):
- Express.js
- Prisma ORM (PostgreSQL)
- JSON Web Tokens (authentification)
- Bcrypt (hash mot de passe)
- Mailtrap (envoi d'emails de test)

## 3. Fonctionnalités réalisées
Frontend:
- Splash screen avec tentative de connexion automatique
- Navigation par barre inférieure: Menu, Réservation, Carte, Profil
- Menu du restaurant (catégories + liste dynamique des plats)
- Gestion des réservations: création, affichage, modification et suppression, validation (pour hôte)
- Authentification utilisateur (connexion, rôles: client, hôte, admin (équivalent à hôte ici))
- Page Profil (affichage données de l'utilisateur + déconnexion)
- Page Carte avec marker Google Maps + bouton recentrage

Backend:
- Authentification (login) avec JWT
- Gestion utilisateurs (rôles, stockage sécurisé des mots de passe)
- Modèle Réservation (statuts: pending, confirmed, cancelled, rejected)
- Modèle Table avec gestion créneaux (timeSlot JSON)
- Endpoints principaux: /auth, /reservations, /tables
- Seed initial (via script Prisma) pour données de base

## 4. Arborescence (vue simplifiée)
```
android/               (projet Android global et module Flutter)
backend/               (API Node.js + Prisma)
frontend/              (code Flutter)
  lib/
    presentation/      (pages, widgets, état)
    domain/            (logique métier)
    services/          (services locaux)
  assets/images/       (images des plats)
README.md              (ce fichier)
```

## 5. Instructions de lancement
### 5.1 Prérequis
- Flutter SDK installé
- Node.js >= 18
- PostgreSQL disponible (local ou distant)

### 5.2 Lancer le Frontend (Flutter)
```bash
cd frontend
flutter pub get
# Configurer la clé Google Maps: dans android/local.properties ajouter MAPS_API_KEY=VOTRE_CLE
flutter run
```

### 5.3 Lancer le Backend (API)
Configurer la base de données dans un fichier `.env` dans `backend/`:
```
DATABASE_URL=postgresql://USER:PASSWORD@HOST:PORT/DB_NAME
JWT_SECRET=REMPLACER_PAR_UN_SECRET
PORT=3000
MAILTRAP_TOKEN=VOTRE_TOKEN_MAILTRAP
```
Installation + migrations + seed:
```bash
cd backend
npm install
npx prisma migrate dev
npm run seed  # optionnel si seed nécessaire
npm run dev
```
L’API écoute sur http://localhost:3000

### 5.4 Migrations Prisma
Pour créer une nouvelle migration:
```bash
npx prisma migrate dev
```

## 6. Configuration des variables d’environnement
Frontend: Android utilise `local.properties` pour la clé Google Maps:
```
MAPS_API_KEY=VOTRE_CLE_GOOGLE_MAPS
```
Backend (`backend/.env`): voir section 5.3.
