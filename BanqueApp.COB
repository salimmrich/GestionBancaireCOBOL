       IDENTIFICATION DIVISION.
       PROGRAM-ID. GestionBancaireCSV.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FichierComptes ASSIGN TO "comptes.csv"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  FichierComptes.
       01  EnregistrementCompte.
           05  NumeroCompte     PIC X(5).
           05  FILLER           PIC X VALUE ",".
           05  NomCompte        PIC X(20).
           05  FILLER           PIC X VALUE ",".
           05  SoldeCompte      PIC 9(6)V99.

       WORKING-STORAGE SECTION.
       01  WS-EOF             PIC X VALUE 'N'.
           88  FIN-DE-FICHIER  VALUE 'Y'.

       01  WS-NumeroCompte    PIC 9(5).
       01  WS-NomCompte       PIC X(20).
       01  WS-SoldeCompte     PIC 9(6)V99.
       01  WS-Choix           PIC 9.
       01  WS-Montant         PIC 9(5)V99.

       01  WS-SoldeTemp       PIC 9(6)V99.

       PROCEDURE DIVISION.

       PROCEDURE-PRINCIPALE.
           PERFORM MENU.
           STOP RUN.

       MENU.
           DISPLAY "**********************".
           DISPLAY "* Gestion Bancaire  *".
           DISPLAY "**********************".
           DISPLAY "1. Créer un Compte".
           DISPLAY "2. Déposer de l'Argent".
           DISPLAY "3. Retirer de l'Argent".
           DISPLAY "4. Afficher Info Compte".
           DISPLAY "5. Quitter".
           DISPLAY "Choisissez une option: ".
           ACCEPT WS-Choix.

           EVALUATE WS-Choix
               WHEN 1
                   PERFORM CREER-COMPTE
               WHEN 2
                   PERFORM DEPOSER
               WHEN 3
                   PERFORM RETIRER
               WHEN 4
                   PERFORM AFFICHER-COMPTE
               WHEN 5
                   STOP RUN
               WHEN OTHER
                   DISPLAY "Choix invalide. Veuillez réessayer."
                   PERFORM MENU
           END-EVALUATE.

       CREER-COMPTE.
           DISPLAY "Entrez le Numéro de Compte: ".
           ACCEPT WS-NumeroCompte.
           DISPLAY "Entrez le Nom du Compte: ".
           ACCEPT WS-NomCompte.
           DISPLAY "Entrez le Solde Initial: ".
           ACCEPT WS-SoldeCompte.

           OPEN EXTEND FichierComptes
           MOVE WS-NumeroCompte TO NumeroCompte
           MOVE WS-NomCompte TO NomCompte
           MOVE WS-SoldeCompte TO SoldeCompte
           WRITE EnregistrementCompte
           CLOSE FichierComptes.

           DISPLAY "Compte créé avec succès!".

       DEPOSER.
           DISPLAY "Entrez le Numéro de Compte: ".
           ACCEPT WS-NumeroCompte.
           DISPLAY "Entrez le Montant à Déposer: ".
           ACCEPT WS-Montant.

           OPEN I-O FichierComptes
           PERFORM READ-COMPTE
           IF FIN-DE-FICHIER
               DISPLAY "Compte non trouvé."
           ELSE
               PERFORM CONVERTIR-SOLDE
               ADD WS-Montant TO WS-SoldeCompte
               PERFORM ECRIRE-COMPTE
               DISPLAY "Dépôt effectué avec succès!"
           END-IF.
           CLOSE FichierComptes.

       RETIRER.
           DISPLAY "Entrez le Numéro de Compte: ".
           ACCEPT WS-NumeroCompte.
           DISPLAY "Entrez le Montant à Retirer: ".
           ACCEPT WS-Montant.

           OPEN I-O FichierComptes
           PERFORM READ-COMPTE
           IF FIN-DE-FICHIER
               DISPLAY "Compte non trouvé."
           ELSE
               PERFORM CONVERTIR-SOLDE
               IF WS-Montant > WS-SoldeCompte
                   DISPLAY "Solde insuffisant! Retrait impossible."
               ELSE
                   SUBTRACT WS-Montant FROM WS-SoldeCompte
                   PERFORM ECRIRE-COMPTE
                   DISPLAY "Retrait effectué avec succès!"
               END-IF
           END-IF.
           CLOSE FichierComptes.

       AFFICHER-COMPTE.
           DISPLAY "Entrez le Numéro de Compte: ".
           ACCEPT WS-NumeroCompte.

           OPEN INPUT FichierComptes
           PERFORM READ-COMPTE
           IF FIN-DE-FICHIER
               DISPLAY "Compte non trouvé."
           ELSE
               DISPLAY "Numéro de Compte: " NumeroCompte
               DISPLAY "Nom du Compte: " NomCompte
               DISPLAY "Solde du Compte: " SoldeCompte
           END-IF.
           CLOSE FichierComptes.

       READ-COMPTE.
           READ FichierComptes INTO EnregistrementCompte
               AT END
                   MOVE 'Y' TO WS-EOF
               NOT AT END
                   IF NumeroCompte NOT = WS-NumeroCompte
                       PERFORM READ-COMPTE
                   END-IF
           END-READ.

       CONVERTIR-SOLDE.
           MOVE SoldeCompte TO WS-SoldeTemp
           MOVE WS-SoldeTemp TO WS-SoldeCompte.

       ECRIRE-COMPTE.
           MOVE WS-SoldeCompte TO SoldeCompte
           REWRITE EnregistrementCompte.
