package edu.sm.menu;

import edu.sm.app.springai.service2.AiServiceshop;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Slf4j
@ActiveProfiles("dev")
class AiDbServiceTests {

    @Autowired
    AiServiceshop aiServiceDbBased;

    @Test
    void testAiServiceDbBasedOrderProcessing() throws Exception {
        log.info("=== AI DB 서비스 주문 처리 테스트 시작 ===");
        
        // 테스트 주문들
        String[] testOrders = {
            "돈코츠라멘에 면 추가하고 차슈도 넣어주세요.",
            "소유라멘 하나랑, 미소라멘 하나에 교자 추가해주세요.",
            "시오라멘 두 개 주세요.",
            "미소라멘에 계란 추가해주세요."
        };
        
        for (int i = 0; i < testOrders.length; i++) {
            String order = testOrders[i];
            log.info("📝 테스트 주문 {}: {}", i + 1, order);
            
            try {
                // AI 주문 처리
                String result = aiServiceDbBased.processOrder(order);
                
                // 결과 검증
                assertThat(result).isNotNull();
                assertThat(result).isNotEmpty();
                
                log.info("✅ 주문 처리 성공");
                log.info("🤖 AI 응답: {}", result);
                
                // JSON 형식 검증 (간단한 검증)
                assertThat(result.trim()).startsWith("[");
                assertThat(result.trim()).endsWith("]");
                
                // 메뉴 이름이 포함되어 있는지 확인
                assertThat(result).containsAnyOf("돈코츠라멘", "소유라멘", "미소라멘", "시오라멘");
                
                log.info("✅ JSON 형식 검증 완료");
                
            } catch (Exception e) {
                log.error("❌ 주문 처리 실패: {}", e.getMessage(), e);
                throw e;
            }
            
            log.info("---");
        }
        
        log.info("=== AI DB 서비스 주문 처리 테스트 완료 ===");
    }
    
    @Test
    void testAiServiceWithInvalidOrder() throws Exception {
        log.info("=== 잘못된 주문 테스트 시작 ===");
        
        String invalidOrder = "존재하지 않는 메뉴 주세요.";
        
        try {
            String result = aiServiceDbBased.processOrder(invalidOrder);
            
            log.info("🤖 AI 응답: {}", result);
            
            // AI가 적절히 처리했는지 확인 (오류 메시지나 빈 배열 등)
            assertThat(result).isNotNull();
            
        } catch (Exception e) {
            log.info("⚠️ 예상된 오류 발생: {}", e.getMessage());
            // 예외가 발생하는 것도 정상적인 동작일 수 있음
        }
        
        log.info("=== 잘못된 주문 테스트 완료 ===");
    }
    
    @Test
    void testAiServiceWithComplexOrder() throws Exception {
        log.info("=== 복잡한 주문 테스트 시작 ===");
        
        String complexOrder = "돈코츠라멘 두 개에 면 추가하고 차슈도 넣어주세요. 그리고 미소라멘 하나에 교자 추가해주세요.";
        
        try {
            String result = aiServiceDbBased.processOrder(complexOrder);
            
            log.info("📝 복잡한 주문: {}", complexOrder);
            log.info("🤖 AI 응답: {}", result);
            
            // 결과 검증
            assertThat(result).isNotNull();
            assertThat(result).isNotEmpty();
            
            // 여러 메뉴가 포함되어 있는지 확인
            assertThat(result).contains("돈코츠라멘");
            assertThat(result).contains("미소라멘");
            
            log.info("✅ 복잡한 주문 처리 성공");
            
        } catch (Exception e) {
            log.error("❌ 복잡한 주문 처리 실패: {}", e.getMessage(), e);
            throw e;
        }
        
        log.info("=== 복잡한 주문 테스트 완료 ===");
    }
    
    @Test
    void testAiServicePerformance() throws Exception {
        log.info("=== AI 서비스 성능 테스트 시작 ===");
        
        String order = "돈코츠라멘에 면 추가하고 차슈도 넣어주세요.";
        int testCount = 5;
        
        long totalTime = 0;
        
        for (int i = 0; i < testCount; i++) {
            long startTime = System.currentTimeMillis();
            
            try {
                String result = aiServiceDbBased.processOrder(order);
                
                long endTime = System.currentTimeMillis();
                long duration = endTime - startTime;
                totalTime += duration;
                
                log.info("⏱️ 테스트 {}: {}ms", i + 1, duration);
                
                assertThat(result).isNotNull();
                
            } catch (Exception e) {
                log.error("❌ 성능 테스트 중 오류 발생", e);
                throw e;
            }
        }
        
        long averageTime = totalTime / testCount;
        log.info("📊 평균 응답 시간: {}ms", averageTime);
        log.info("📊 총 테스트 시간: {}ms", totalTime);
        
        // 성능 기준 설정 (예: 10초 이내)
        assertThat(averageTime).isLessThan(10000);
        
        log.info("=== AI 서비스 성능 테스트 완료 ===");
    }
}
