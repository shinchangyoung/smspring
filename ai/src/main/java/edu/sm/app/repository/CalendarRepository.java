package edu.sm.app.repository;

import edu.sm.app.dto.CalendarEvent;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CalendarRepository extends SmRepository<CalendarEvent, Integer> {
}
