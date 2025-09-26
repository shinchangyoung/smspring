package edu.sm.cate;

import edu.sm.app.dto.Cate;
import edu.sm.app.dto.Product;
import edu.sm.app.service.CateService;
import edu.sm.app.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class InsertTests {
    @Autowired
    CateService cateService;
    @Test
    void contextLoads() {
        Cate cate = Cate.builder().cateId(40).cateName("가방").build();
        try {
            cateService.register(cate);
            log.info("OK");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
