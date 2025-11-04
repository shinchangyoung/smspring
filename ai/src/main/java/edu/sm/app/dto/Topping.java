package edu.sm.app.dto;

import lombok.*;

@Data
public class Topping {
    private Integer toppingId;
    private String toppingName;
    private Integer price;
    private String description;
    private String imageName;
    private Boolean isAvailable;
    private String createdAt;
    private String updatedAt;
}
