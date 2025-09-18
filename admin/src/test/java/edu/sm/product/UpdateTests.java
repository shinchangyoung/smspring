package edu.sm.product;

import edu.sm.app.dto.Cust;
import edu.sm.app.dto.Product;
import edu.sm.app.service.CustService;
import edu.sm.app.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class UpdateTests {

    @Autowired
    ProductService productService;
    @Test
    void contextLoads() throws Exception{
        Product product = Product.builder()
                .productId(18)
                .cateId(20)
                .build();


        log.info(productService.get(18).toString());
    }

}
