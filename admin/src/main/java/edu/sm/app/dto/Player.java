package edu.sm.app.dto;


import lombok.*;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Player {
    private String playerId;
    private String playerName;
    private String position;
    private int age;
    private int nationalityNo;
    private int salary;
    private LocalDateTime playerRegdate;
    private LocalDateTime playerUpdate;
}
