package edu.sm.shop;


import edu.sm.app.dto.Shop;
import edu.sm.app.service.ShopService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class SelectTests {
    @Autowired
    ShopService shopService;

    @Autowired
    MarkerService markerService;

    @Test
    void contextLoads() {
        try {

            List<Shop> list2 = shopService.findByCateNo(10);
            list2.forEach((data)->{log.info(data.toString());});

//            List<Marker> list2 = markerService.findByLoc(200);
//            list2.forEach((data)->{log.info(data.toString());});
//
//            List<Marker> list2 = markerService.get();
//            list.forEach(System.out::println);


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}