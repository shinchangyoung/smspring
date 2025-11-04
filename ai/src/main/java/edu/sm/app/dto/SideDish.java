package edu.sm.app.dto;

import lombok.*;

@Data
public class SideDish {
    private Integer sideDishId;
    private String sideDishName;
    private Integer price;
    private String description;
    private String imageName;
    private Boolean isAvailable;
    private String createdAt;
    private String updatedAt;
}
