package edu.sm.controller;

import edu.sm.app.dto.CalendarEvent;
import edu.sm.app.service.CalendarService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class CalendarController {

    private final CalendarService calendarService;

    @GetMapping("/events")
    public List<CalendarEvent> getEvents() throws Exception {
        return calendarService.get();
    }

    @PostMapping("/events")
    public void addEvent(@RequestBody CalendarEvent event) throws Exception {
        System.out.println("Received event for registration: " + event);
        calendarService.register(event);
    }

    @PutMapping("/events/{id}")
    public ResponseEntity<Void> updateEvent(@PathVariable int id, @RequestBody CalendarEvent event) throws Exception {
        event.setId(id);
        System.out.println("Received event for update: " + event);
        calendarService.modify(event);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/events/{id}")
    public ResponseEntity<Void> deleteEvent(@PathVariable int id) throws Exception {
        System.out.println("Received request to delete event with id: " + id);
        calendarService.remove(id);
        return ResponseEntity.ok().build();
    }
}
