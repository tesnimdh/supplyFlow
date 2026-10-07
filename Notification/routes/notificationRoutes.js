const express = require("express");
const db = require("../services/db");
const envoyerEmail = require("../services/emailService");

const router = express.Router();

router.post("/", (req, res) => {

    

    const {
        idCommande,
        idFournisseur,
        nouvelEtat,
        anomalie
    } = req.body;

    console.log("BODY REÇU DE MULE :", req.body);


    

    if (!idCommande || !idFournisseur || !nouvelEtat) {

        return res.status(400).json({
            message:
                "idCommande, idFournisseur et nouvelEtat sont obligatoires"
        });
    }


    

    const type =
        nouvelEtat === "VALIDEE"
            ? "VALIDATION"
            : "ANOMALIE";


    

    const message =
        nouvelEtat === "VALIDEE"

            ? `Bonjour,

Votre commande ${idCommande} a été validée.

Cordialement,
Service Gestion des Commandes`

            : `Bonjour,

Votre commande ${idCommande} n'a pas été validée.

Anomalie détectée : ${anomalie || "Aucune anomalie précisée"}

Cordialement,
Service Gestion des Commandes`;



    const sqlFournisseur = `
        SELECT email
        FROM fournisseur
        WHERE id_fournisseur = ?
    `;

    db.query(
        sqlFournisseur,
        [idFournisseur],
        (err, fournisseurs) => {

            if (err) {

                console.error(
                    "Erreur recherche fournisseur :",
                    err.message
                );

                return res.status(500).json({
                    message:
                        "Erreur lors de la recherche du fournisseur"
                });
            }


            
            if (fournisseurs.length === 0) {

                return res.status(404).json({
                    message: "Fournisseur introuvable"
                });
            }


            const emailFournisseur = fournisseurs[0].email;



            const idNotification =
                "NOTIF" + Date.now();

            const sqlNotification = `
                INSERT INTO notification
                (
                    id_notification,
                    id_commande,
                    id_fournisseur,
                    type,
                    message,
                    date_envoi,
                    statut
                )
                VALUES (?, ?, ?, ?, ?, NOW(), ?)
            `;


            db.query(
                sqlNotification,
                [
                    idNotification,
                    idCommande,
                    idFournisseur,
                    type,
                    message,
                    "ENVOYEE"
                ],
                async (err) => {

                    if (err) {

                        console.error(
                            "Erreur insertion notification :",
                            err.message
                        );

                        return res.status(500).json({
                            message:
                                "Erreur lors de l'enregistrement"
                        });
                    }


                    

                    try {

                        await envoyerEmail(
                            emailFournisseur,
                            `Notification concernant la commande ${idCommande}`,
                            message
                        );


                       

                        return res.json({

                            message:
                                "Notification enregistrée et email envoyé",

                            idNotification:
                                idNotification,

                            destinataire:
                                emailFournisseur,

                            type:
                                type
                        });

                    } catch (error) {

                        console.error(
                            "Erreur envoi email :",
                            error.message
                        );


                        return res.status(500).json({

                            message:
                                "Notification enregistrée mais email non envoyé",

                            idNotification:
                                idNotification,

                            erreur:
                                error.message
                        });
                    }
                }
            );
        }
    );
});


module.exports = router;

