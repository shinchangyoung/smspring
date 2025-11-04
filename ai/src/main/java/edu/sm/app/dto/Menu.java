package edu.sm.app.dto;

import lombok.*;

@Data
public class Menu {
    private Integer menuId;
    private String menuName;
    private Integer price;
    private String imageName;
    private String category;
    private String description;
    private Boolean isAvailable;
    private String createdAt;
    private String updatedAt;
}