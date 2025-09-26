package edu.sm.app.dto;


import lombok.*;

import java.security.Timestamp;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class Cust {
    private String custId;
    private String custPwd;
    private String custName;
    private Timestamp custRegdate;
    private Timestamp custUpdate;
}