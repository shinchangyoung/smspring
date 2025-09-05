package edu.sm.app.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Content {
    private int target;
    private String title;
    private String img;
    private double lat;
    private double lng;
    private int type;
    private String addr;
}