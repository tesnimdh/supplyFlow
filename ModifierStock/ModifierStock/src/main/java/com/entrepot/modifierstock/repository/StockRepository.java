package com.entrepot.modifierstock.repository;

import com.entrepot.modifierstock.model.Stock;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StockRepository extends JpaRepository<Stock, String> {

    Optional<Stock> findByIdProduit(String idProduit);
}