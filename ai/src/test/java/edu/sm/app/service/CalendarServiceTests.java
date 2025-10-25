package edu.sm.app.service;

import edu.sm.app.dto.CalendarEvent;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class CalendarServiceTests {

    @Autowired
    CalendarService calendarService;

    @Test
    void insertTest() {
        // 테스트용 CalendarEvent 객체 생성
        CalendarEvent event = new CalendarEvent();
        event.setTitle("JUnit Test Event");
        event.setStart("2024-05-24");
        event.setEnd("2024-05-25");

        try {
            // 서비스의 register 메소드 호출
            calendarService.register(event);
            log.info("SUCCESS: 테스트 이벤트가 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            // 에러 발생 시 로그 출력
            log.error("ERROR: 테스트 이벤트 등록 중 오류가 발생했습니다.", e);
        }
    }
}
