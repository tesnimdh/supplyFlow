package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
	private static Connection connect;
	   private static final String URL = System.getenv("DB_URL");
	    private static final String USER = System.getenv("DB_USERNAME");
	    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    private Connexion() {
        try {
        	System.out.println("DB_URL = " + URL);
        	System.out.println("DB_USERNAME = " + USER);
        	System.out.println("DB_PASSWORD défini = " + (PASSWORD != null));
            Class.forName("com.mysql.cj.jdbc.Driver");
           
            connect = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Pilote JDBC non trouvé : " + e.getMessage());
            
        } catch (SQLException e) {
            System.err.println("Erreur de connexion à la base de données : " + e.getMessage());
        }
    }

    public static Connection getInstance() {
        if (connect == null) {
            synchronized (Connexion.class) {
                if (connect == null) {
                    new Connexion();
                }
            }
        }
        return connect;
    
	    }

}
