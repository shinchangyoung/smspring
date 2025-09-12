package edu.sm.splayer;



import edu.sm.app.dto.Player;
import edu.sm.app.service.PlayerService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class PlayerTest {
    @Autowired
    PlayerService playerService;
    @Test
        void getall() {
        List<Player> list = null;
        try {
            list = playerService.get();
            list.forEach(splayer -> log.info(splayer.toString()));
            log.info("Select All End ------------------------------------------");

        } catch (Exception e) {
            log.info("Error Test ...");
            e.printStackTrace();
        }
    }
//    @Test
//    void get() {
//        Splayer splayer = null;
//        try {
//            splayer = splayerService.get("id01");
//            log.info(splayer.toString());
//            if(splayer != null){
//                log.info(splayer.toString());
//            }
//            log.info("Select All End ------------------------------------------");
//
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }




}
