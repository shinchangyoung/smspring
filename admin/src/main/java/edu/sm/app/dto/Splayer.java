package edu.sm.app.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Splayer {
    private String id;
    private String name;
    private String position;
    private String team;
    private int age;
    private int salary;
}

