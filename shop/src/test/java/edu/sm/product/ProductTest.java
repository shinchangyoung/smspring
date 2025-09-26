package edu.sm.product;

import edu.sm.app.dto.Product;
import edu.sm.app.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class ProductTest {

    @Autowired
    ProductService productService;


    @Test
    void getall() {
        List<Product> list = null;
        try {
            list = productService.get();
            list.forEach(product -> log.info(product.toString()));
            log.info("Select All End ------------------------------------------");

        } catch (Exception e) {
            log.info("Error Test ...");
            e.printStackTrace();
        }
    }


//    @Test
//    void update() {
//        Product product = Product.builder().productName("반바지2").productPrice(8000).productImg("sh2.jpg").discountRate(0.3).cateId(10).build();
//        try {
//            productService.modify(product);
//            log.info("Update End ------------------------------------------");
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }


//    @Test
//    void get2() {
//        Product product = null;
//        try {
//            product = productService.get(1007);
//            log.info(product.toString());
//            log.info("Select End ------------------------------------------");
//
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }
    @Test
    void delete() {
        try {
            productService.remove(1007);
            log.info("Delete End ------------------------------------------");
        } catch (Exception e) {
            log.info("Error Test ...");
            e.printStackTrace();
        }
    }

}