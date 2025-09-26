package edu.sm.product;

import edu.sm.app.dto.Product;
import edu.sm.app.dto.ProductSearch;
import edu.sm.app.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;


@SpringBootTest
@Slf4j
public class SearchTest {
    @Autowired
    ProductService productService;

    @Test
    @DisplayName("카테고리 ID로 상품 검색 테스트")
    void searchProductByCategory() throws Exception {
        // Arrange: 검색 조건을 준비합니다. (카테고리 ID: 20)
        List<Product> list = null;
        ProductSearch productSearch = ProductSearch.builder()
                .cateId(20)
                .build();

        // Act: 준비된 조건으로 상품 목록을 검색합니다.
        list = productService.searchProductList(productSearch);

        // Assert/Verify: 검색 결과를 로그로 출력하여 확인합니다.
        list.forEach((c)->{log.info(c.toString());});
    }
}
