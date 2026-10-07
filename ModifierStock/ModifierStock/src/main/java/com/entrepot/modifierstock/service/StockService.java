package com.entrepot.modifierstock.service;

import com.entrepot.modifierstock.model.Stock;
import com.entrepot.modifierstock.repository.StockRepository;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class StockService {

    private final StockRepository stockRepository;

    public StockService(StockRepository stockRepository) {
        this.stockRepository = stockRepository;
    }

    public Stock diminuerStock(String idProduit, int quantiteCommandee) {

        Stock stock = stockRepository.findByIdProduit(idProduit)
                .orElseThrow(() ->
                    new RuntimeException(
                        "Stock introuvable pour le produit : " + idProduit
                    )
                );

        if (quantiteCommandee <= 0) {
            throw new RuntimeException(
                "La quantité commandée doit être supérieure à 0"
            );
        }

        if (stock.getQuantite() < quantiteCommandee) {
            throw new RuntimeException(
                "Stock insuffisant pour le produit : " + idProduit
                + ". Stock disponible : " + stock.getQuantite()
            );
        }

        int nouvelleQuantite = stock.getQuantite() - quantiteCommandee;

        stock.setQuantite(nouvelleQuantite);
        stock.setDateMiseAJour(LocalDateTime.now());

        return stockRepository.save(stock);
    }
}