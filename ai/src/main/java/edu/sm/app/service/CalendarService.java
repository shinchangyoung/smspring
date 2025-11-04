package edu.sm.app.service;


import edu.sm.app.dto.CalendarEvent;
import edu.sm.app.repository.CalendarRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CalendarService implements SmService<CalendarEvent, Integer> {

    final CalendarRepository calendarRepository;

    @Override
    public void register(CalendarEvent calendarEvent) throws Exception {
        calendarRepository.insert(calendarEvent);
    }

    @Override
    public void modify(CalendarEvent calendarEvent) throws Exception {
        calendarRepository.update(calendarEvent);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        calendarRepository.delete(integer);
    }

    @Override
    public List<CalendarEvent> get() throws Exception {
        return calendarRepository.selectAll();
    }

    @Override
    public CalendarEvent get(Integer integer) throws Exception {
        return calendarRepository.select(integer);
    }
}
