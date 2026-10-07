
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class IsExistImpl {

    public Commande getCommande(String idCommande) {

        Connection connection = Connexion.getInstance();

        Commande commande = null;

        String selectCommandeQuery =
                "SELECT id_commande, reference, id_fournisseur, date_commande, statut " +
                "FROM commande " +
                "WHERE id_commande = ?";

        try {

            PreparedStatement preparedStatement =
                    connection.prepareStatement(selectCommandeQuery);

            preparedStatement.setString(1, idCommande);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                commande = new Commande();

                commande.setIdCommande(
                        resultSet.getString("id_commande")
                );

                commande.setReference(
                        resultSet.getString("reference")
                );

                commande.setIdFournisseur(
                        resultSet.getString("id_fournisseur")
                );

                commande.setDateCommande(
                        resultSet.getTimestamp("date_commande")
                );

                commande.setStatut(
                        resultSet.getString("statut")
                );
            }

            resultSet.close();
            preparedStatement.close();

        } catch (SQLException e) {

            System.err.println(
                    "Erreur lors de la récupération de la commande : "
                    + e.getMessage()
            );
        }

        return commande;
    }}

