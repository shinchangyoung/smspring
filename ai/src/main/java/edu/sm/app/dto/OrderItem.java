package edu.sm.app.dto;

import lombok.*;

import java.util.List;

@Data
public class OrderItem {
    private String menuName;
    private Integer quantity;
    private Integer price;
    private String imageName;
    private Boolean extraNoodles;
    private String tasteStrength;
    private List<String> toppings;
    private List<String> sideDishes;
}
