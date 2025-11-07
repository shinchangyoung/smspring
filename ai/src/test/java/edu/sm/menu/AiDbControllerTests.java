package edu.sm.menu;

import edu.sm.app.dto.Menu;
import edu.sm.app.dto.Topping;
import edu.sm.app.dto.SideDish;
import edu.sm.app.service.MenuService;
import edu.sm.app.service.ToppingService;
import edu.sm.app.service.SideDishService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureWebMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@AutoConfigureWebMvc
@Slf4j
@ActiveProfiles("dev")
class AiDbControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;
    
    @Autowired
    private MenuService menuService;
    
    @Autowired
    private ToppingService toppingService;
    
    @Autowired
    private SideDishService sideDishService;

    @Test
    void testOrderEndpoint() throws Exception {
        log.info("=== 주문 API 엔드포인트 테스트 시작 ===");

        String order = "돈코츠라멘에 면 추가하고 차슈도 넣어주세요.";

        MvcResult result = mockMvc.perform(post("/ai/db/order")
                .param("order", order)
                .contentType(MediaType.APPLICATION_FORM_URLENCODED))
                .andExpect(status().isOk())
                .andReturn();

        String responseContent = result.getResponse().getContentAsString();
        log.info("📝 주문: {}", order);
        log.info("🤖 API 응답: {}", responseContent);

        // 응답이 JSON 형식인지 확인
        assertThat(responseContent).isNotNull();
        assertThat(responseContent.trim()).startsWith("[");
        assertThat(responseContent.trim()).endsWith("]");

        log.info("=== 주문 API 엔드포인트 테스트 완료 ===");
    }

    @Test
    void testGetMenusEndpoint() throws Exception {
        log.info("=== 메뉴 조회 API 엔드포인트 테스트 시작 ===");
        
        // 모든 메뉴 조회
        MvcResult result = mockMvc.perform(get("/ai/db/menus"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("📋 전체 메뉴 API 응답: {}", responseContent);
        
        // 사용 가능한 메뉴 조회
        MvcResult availableResult = mockMvc.perform(get("/ai/db/menus/available"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String availableContent = availableResult.getResponse().getContentAsString();
        log.info("📋 사용 가능한 메뉴 API 응답: {}", availableContent);
        
        // 응답이 배열 형식인지 확인
        assertThat(responseContent.trim()).startsWith("[");
        assertThat(availableContent.trim()).startsWith("[");
        
        log.info("=== 메뉴 조회 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    void testGetToppingsEndpoint() throws Exception {
        log.info("=== 토핑 조회 API 엔드포인트 테스트 시작 ===");
        
        // 모든 토핑 조회
        MvcResult result = mockMvc.perform(get("/ai/db/toppings"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("🥩 전체 토핑 API 응답: {}", responseContent);
        
        // 사용 가능한 토핑 조회
        MvcResult availableResult = mockMvc.perform(get("/ai/db/toppings/available"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String availableContent = availableResult.getResponse().getContentAsString();
        log.info("🥩 사용 가능한 토핑 API 응답: {}", availableContent);
        
        assertThat(responseContent.trim()).startsWith("[");
        assertThat(availableContent.trim()).startsWith("[");
        
        log.info("=== 토핑 조회 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    void testGetSideDishesEndpoint() throws Exception {
        log.info("=== 사이드 메뉴 조회 API 엔드포인트 테스트 시작 ===");
        
        // 모든 사이드 메뉴 조회
        MvcResult result = mockMvc.perform(get("/ai/db/side-dishes"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("🥟 전체 사이드 메뉴 API 응답: {}", responseContent);
        
        // 사용 가능한 사이드 메뉴 조회
        MvcResult availableResult = mockMvc.perform(get("/ai/db/side-dishes/available"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String availableContent = availableResult.getResponse().getContentAsString();
        log.info("🥟 사용 가능한 사이드 메뉴 API 응답: {}", availableContent);
        
        assertThat(responseContent.trim()).startsWith("[");
        assertThat(availableContent.trim()).startsWith("[");
        
        log.info("=== 사이드 메뉴 조회 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    @Transactional
    void testAddMenuEndpoint() throws Exception {
        log.info("=== 메뉴 추가 API 엔드포인트 테스트 시작 ===");
        
        Menu testMenu = new Menu();
        testMenu.setMenuName("API테스트라멘");
        testMenu.setPrice(7500);
        testMenu.setImageName("api_test.jpg");
        testMenu.setCategory("라멘");
        testMenu.setDescription("API 테스트용 라멘");
        testMenu.setIsAvailable(true);
        
        String menuJson = objectMapper.writeValueAsString(testMenu);
        
        MvcResult result = mockMvc.perform(post("/ai/db/menus")
                .contentType(MediaType.APPLICATION_JSON)
                .content(menuJson))
                .andExpect(status().isOk())
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("📝 메뉴 추가 API 응답: {}", responseContent);
        
        // 성공 메시지 확인
        assertThat(responseContent).contains("성공적으로 추가되었습니다");
        
        log.info("=== 메뉴 추가 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    @Transactional
    void testAddToppingEndpoint() throws Exception {
        log.info("=== 토핑 추가 API 엔드포인트 테스트 시작 ===");
        
        Topping testTopping = new Topping();
        testTopping.setToppingName("API테스트토핑");
        testTopping.setPrice(800);
        testTopping.setDescription("API 테스트용 토핑");
        testTopping.setIsAvailable(true);
        
        String toppingJson = objectMapper.writeValueAsString(testTopping);
        
        MvcResult result = mockMvc.perform(post("/ai/db/toppings")
                .contentType(MediaType.APPLICATION_JSON)
                .content(toppingJson))
                .andExpect(status().isOk())
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("🥩 토핑 추가 API 응답: {}", responseContent);
        
        // 성공 메시지 확인
        assertThat(responseContent).contains("성공적으로 추가되었습니다");
        
        log.info("=== 토핑 추가 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    @Transactional
    void testAddSideDishEndpoint() throws Exception {
        log.info("=== 사이드 메뉴 추가 API 엔드포인트 테스트 시작 ===");
        
        SideDish testSideDish = new SideDish();
        testSideDish.setSideDishName("API테스트사이드");
        testSideDish.setPrice(2500);
        testSideDish.setDescription("API 테스트용 사이드 메뉴");
        testSideDish.setIsAvailable(true);
        
        String sideDishJson = objectMapper.writeValueAsString(testSideDish);
        
        MvcResult result = mockMvc.perform(post("/ai/db/side-dishes")
                .contentType(MediaType.APPLICATION_JSON)
                .content(sideDishJson))
                .andExpect(status().isOk())
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("🥟 사이드 메뉴 추가 API 응답: {}", responseContent);
        
        // 성공 메시지 확인
        assertThat(responseContent).contains("성공적으로 추가되었습니다");
        
        log.info("=== 사이드 메뉴 추가 API 엔드포인트 테스트 완료 ===");
    }
    
    @Test
    void testCategoryEndpoint() throws Exception {
        log.info("=== 카테고리별 메뉴 조회 API 엔드포인트 테스트 시작 ===");
        
        MvcResult result = mockMvc.perform(get("/ai/db/menus/category/라멘"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andReturn();
        
        String responseContent = result.getResponse().getContentAsString();
        log.info("📋 라멘 카테고리 메뉴 API 응답: {}", responseContent);
        
        // 응답이 배열 형식인지 확인
        assertThat(responseContent.trim()).startsWith("[");
        
        log.info("=== 카테고리별 메뉴 조회 API 엔드포인트 테스트 완료 ===");
    }
}
