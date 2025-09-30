package edu.sm.testai1;

import edu.sm.app.springai.service1.AiService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import reactor.core.publisher.Flux;

@SpringBootTest
@Slf4j
class AiServiceTests1 {

    @Autowired
    AiService aiService;

    @Test
    void contextLoads() {
        String quetion ="천안에 맛집 알려줘";
        Flux<String> result = aiService.generateStreamText(quetion);
        result.collectList().block().stream().forEach(System.out::println);
//        log.info("result:{}", result);
    }
}
