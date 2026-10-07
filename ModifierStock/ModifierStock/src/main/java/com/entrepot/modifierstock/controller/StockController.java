package com.entrepot.modifierstock.controller;

import com.entrepot.modifierstock.model.Stock;
import com.entrepot.modifierstock.service.StockService;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/stock")
public class StockController {

    private final StockService stockService;

    public StockController(StockService stockService) {
        this.stockService = stockService;
    }

    @PutMapping("/{idProduit}/diminuer")
    public Stock diminuerStock(
            @PathVariable String idProduit,
            @RequestParam int quantite) {

        return stockService.diminuerStock(idProduit, quantite);
    }
    
    @GetMapping("/test")
    public String test() {
        return "StockController fonctionne";
    }
    
}