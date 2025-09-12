package edu.sm.product;

import edu.sm.app.dto.Product;
import edu.sm.app.dto.ProductSearch;
import edu.sm.app.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;


@SpringBootTest
@Slf4j
public class SearchTest {
    @Autowired
    ProductService productService;

    @Test
    void contextLoads() throws Exception {
        List<Product> list = null;
        ProductSearch productSearch = ProductSearch.builder()
                .productName("여름")
                .startDate("2025-09-01")
                .endDate("2025-09-10")
                .build();
        list = productService.searchProductList(productSearch);
        list.forEach((c)->{log.info(c.toString());});

    }
}
