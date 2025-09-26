package edu.sm.phone;

import edu.sm.app.service.PhoneService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Map;

@SpringBootTest
@Slf4j
class SelectTests {

    @Autowired
    PhoneService phoneService;

    @Test
    void testGetSalesByBrand() {
        try {
            List<Map<String, Object>> salesData = phoneService.getSalesByBrand();
            
            log.info("=== 월별 브랜드별 매출 합계 데이터 ===");
            for (Map<String, Object> data : salesData) {
                log.info("월: {}, 브랜드: {}, 매출합계: {}", 
                    data.get("month"), 
                    data.get("phone_name"), 
                    data.get("value"));
            }
            log.info("총 데이터 개수: {}", salesData.size());
            log.info("Select Sales Data End ------------------------------------------");

        } catch (Exception e) {
            log.error("Error Test - getSalesByBrand", e);
        }
    }

    @Test
    void testGetAverageSalesByBrand() {
        try {
            List<Map<String, Object>> averageData = phoneService.getAverageSalesByBrand();
            
            log.info("=== 월별 브랜드별 매출 평균 데이터 ===");
            for (Map<String, Object> data : averageData) {
                log.info("월: {}, 브랜드: {}, 매출평균: {}", 
                    data.get("month"), 
                    data.get("phone_name"), 
                    data.get("value"));
            }
            log.info("총 데이터 개수: {}", averageData.size());
            log.info("Select Average Data End ------------------------------------------");

        } catch (Exception e) {
            log.error("Error Test - getAverageSalesByBrand", e);
        }
    }

    @Test
    void testBothMethods() {
        try {
            log.info("=== 통합 테스트 시작 ===");
            
            // 매출 합계 데이터 조회
            List<Map<String, Object>> salesData = phoneService.getSalesByBrand();
            log.info("매출 합계 데이터 조회 완료: {} 건", salesData.size());
            
            // 매출 평균 데이터 조회
            List<Map<String, Object>> averageData = phoneService.getAverageSalesByBrand();
            log.info("매출 평균 데이터 조회 완료: {} 건", averageData.size());
            
            // 데이터 검증
            if (salesData.size() == averageData.size()) {
                log.info("✅ 데이터 개수가 일치합니다.");
            } else {
                log.warn("⚠️ 데이터 개수가 일치하지 않습니다. 합계: {}, 평균: {}", 
                    salesData.size(), averageData.size());
            }
            
            log.info("=== 통합 테스트 완료 ===");

        } catch (Exception e) {
            log.error("Error Test - Both Methods", e);
        }
    }
}