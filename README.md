# Carnet numérique du troupeau — app mobile

Application Flutter (mode hors ligne d'abord) : anti-vol biométrique,
optimiseur de ration, prévention des conflits de transhumance.

## État actuel

Architecture + thème graphique complet + toutes les interfaces (gabarits
visuels, navigation câblée). La logique métier (DAO, réseau, synchronisation,
repositories) reste en `UnimplementedError` comme points d'extension. Les flux
d'interaction (vente / transfert de propriété) sont laissés de côté pour l'instant.

## Écrans implémentés (27)

### Anti-vol
- Accueil (menu + derniers animaux)
- Enrôlement : capture → formulaire → confirmation
- Vérification : capture → résultat (reconnu / volé / inconnu)
- Signaler un vol
- Mon cheptel (liste)
- Fiche animal (détail)

### Ration
- Accueil
- Flux : troupeau → aliments → résultat
- Historique des rations

### Carte
- Accueil (carte + légende)
- Signaler une zone cultivée
- Historique de trajet
- Alerte de conflit (plein écran)

### Réglages
- Accueil
- Profil, Synchronisation, Langue, Code d'agent, Aide

### Global
- Splash, Onboarding, Shell (navigation 4 onglets)

## Architecture

```
lib/
├── app.dart / main.dart          MaterialApp, thème, routes
├── core/
│   ├── app/                      AppServices (DI) + AppScope
│   ├── config/                   constantes
│   ├── database/ + daos/         SQLite local (structure)
│   ├── network/                  ApiClient (structure)
│   ├── sync/                     SyncService (structure)
│   └── theme/                    palette, typo, spacing, ThemeData
├── data/models/ + repositories/  modèles + logique (structure)
├── features/                     tous les écrans par module
└── shared/widgets/               StatusBadge, ConnectivityIndicator,
                                  ModuleTile, CameraFrame, LabeledField,
                                  DetailRow, AnimalListTile, SectionHeader, BrandMark
```
