package edu.sm.app.dto;

import lombok.Data;

@Data
public class CalendarEvent {
    private Long id;
    private String title;
    private String start;
    private String end;
}
