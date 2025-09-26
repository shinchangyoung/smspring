package edu.sm.app.dto;


import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Phone {
    private String phoneCode;
    private  int month;
    private String phoneName;
    private int price;
}
