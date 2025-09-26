package edu.sm.wather;

import edu.sm.util.WeatherUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.parser.ParseException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

@SpringBootTest
@Slf4j
class Wheather1Tests {

    @Value("${app.key.wkey}")
     String key;

    @Test
    void contextLoads() throws IOException, ParseException {
        String loc = "109";
        String regLd = "12A20000";
        Object object = WeatherUtil.getWeather(loc, key);
        log.info("{}", object);
    }

}
