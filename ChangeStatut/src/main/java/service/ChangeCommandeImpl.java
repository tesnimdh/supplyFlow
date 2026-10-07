package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChangeCommandeImpl {
	public String changeStatut(String idCommande, String nouvelEtat) {
		Connection connection = Connexion.getInstance();
		String updatedStatut = null; 
		String updateQuery = "UPDATE commande SET statut = ? WHERE id_commande = ?"; 
		String selectStatutQuery = "SELECT statut FROM commande WHERE id_commande = ?";
		try {
			try (PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) 
			{ updateStatement.setString(1, nouvelEtat); 
			  updateStatement.setString(2, idCommande); 
		int rowsUpdated = updateStatement.executeUpdate();
		if (rowsUpdated == 0) 
		{ System.err.println( "Commande introuvable : " + idCommande ); 
		return null; } }
		try (PreparedStatement selectStatement = connection.prepareStatement(selectStatutQuery))
		{ selectStatement.setString(1, idCommande);
		try (ResultSet resultSet = selectStatement.executeQuery()) {
			if (resultSet.next())
			{ updatedStatut = resultSet.getString("statut"); } 
			} } } 
		catch (SQLException e) { System.err.println( "Erreur lors du changement de statut : " + e.getMessage() ); }
		return updatedStatut; 
		}
}
