
# Gestion Bancaire COBOL

## Description

Ce projet est une application bancaire simple développée en **COBOL**, permettant de gérer des comptes bancaires avec des fonctionnalités telles que :

- **Créer un compte** : Ajoutez un compte avec un solde initial.
- **Déposer de l'argent** : Effectuez un dépôt sur un compte existant.
- **Retirer de l'argent** : Retirez un montant d'un compte existant.
- **Afficher les informations du compte** : Consultez le solde actuel et les informations du compte.

Le projet utilise des fichiers CSV pour stocker et gérer les informations des comptes.

## Fonctionnalités

1. **Créer un Compte Bancaire** : Permet à l'utilisateur de créer un compte avec un numéro, un nom et un solde initial.
2. **Déposer de l'Argent** : Permet à l'utilisateur de déposer une somme d'argent sur un compte existant.
3. **Retirer de l'Argent** : Permet à l'utilisateur de retirer une somme d'argent d'un compte, à condition que le solde soit suffisant.
4. **Afficher les Informations de Compte** : Permet à l'utilisateur de consulter les détails d'un compte.

## Fichier CSV

Le fichier `comptes.csv` est utilisé pour stocker les données des comptes. Chaque ligne représente un compte avec :

- Un numéro de compte.
- Le nom du titulaire.
- Le solde actuel du compte.

Exemple de contenu du fichier CSV :
```csv
12345,John Doe,1000.00
23456,Jane Smith,500.00
