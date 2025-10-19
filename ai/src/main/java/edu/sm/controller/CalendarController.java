package edu.sm.app.springai.controller;

import edu.sm.app.dto.repository.CalendarEvent;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api")
public class CalendarController {

    private final List<CalendarEvent> events = new ArrayList<>();

    @GetMapping("/events")
    public List<CalendarEvent> getEvents() {
        return events;
    }

    @PostMapping("/events")
    public void addEvent(@RequestBody CalendarEvent event) {
        System.out.println("Received event: " + event);
        events.add(event);
    }

}
