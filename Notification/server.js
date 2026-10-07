const express = require("express");
require("dotenv").config();
const db = require("./services/db");

const notificationRoutes = require("./routes/notificationRoutes");

const app = express();

const PORT = 3000;

app.use(express.json());

app.get("/", (req, res) => {
    res.json({
        message: "Notification Service fonctionne"
    });
});

app.use("/api/notifications", notificationRoutes);

app.listen(PORT, () => {
    console.log(`Serveur démarré sur http://localhost:${PORT}`);
});