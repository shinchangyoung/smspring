package edu.sm.app.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Shop {
    int target;
    String title;
    String img;
    double lat;
    double lng;
    int cateNo;

}
