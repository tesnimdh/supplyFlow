const mysql = require("mysql2");

const db = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.getConnection((err, connection) => {

    if (err) {
        console.error("Erreur de connexion à MariaDB :", err.message);
        return;
    }

    console.log("Connexion à MariaDB réussie !");

    connection.release();
});

module.exports = db;