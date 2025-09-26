package edu.sm.scheduler;

import edu.sm.app.dto.AdminMsg;
import edu.sm.app.dto.CarMsg;
import edu.sm.sse.SseCarEmitters;
import edu.sm.sse.SseEmitters;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Random;

@Component
@Slf4j
@RequiredArgsConstructor
public class SSEScheduler {

    private final SseEmitters sseEmitters;
    private final SseCarEmitters sseCarEmitters;

    @Scheduled(cron = "*/10 * * * * *")
    public void sendCount() {

        Random r = new Random();
        int count = r.nextInt(1000)+1;
        sseEmitters.count(count);
    }

    @Scheduled(cron = "*/5 * * * * *")
    public void cronJobDailyUpdate() {
        log.info("====================================================");
        Random r = new Random();
        int content1 = r.nextInt(100)+1;
        int content2 = r.nextInt(1000)+1;
        int content3 = r.nextInt(500)+1;
        int content4 = r.nextInt(10)+1;
        AdminMsg adminMsg = new AdminMsg();
        adminMsg.setContent1(content1);
        adminMsg.setContent2(content2);
        adminMsg.setContent3(content3);
        adminMsg.setContent4(content4);

        sseEmitters.sendData(adminMsg);
        // sseEmitters.count();
//        simpMessageSendingOperations.convertAndSend("/send2",adminMsg);
    }

    @Scheduled(cron = "*/5 * * * * *")
    public void cronJobDailyUpdate2() {
        log.info("====================================================");
        Random r = new Random();
        int car1 = r.nextInt(100)+1;
        int car2 = r.nextInt(1000)+1;
        int car3 = r.nextInt(500)+1;
        int car4 = r.nextInt(10)+1;
        CarMsg carMsg = new CarMsg();
        carMsg.setCar1(car1);
        carMsg.setCar2(car2);
        carMsg.setCar3(car3);
        carMsg.setCar4(car4);


        sseCarEmitters.sendData(carMsg);


//        sseEmitters.sendData(car);
    }

}