package edu.sm.menu;

import edu.sm.app.dto.Menu;
import edu.sm.app.dto.Topping;
import edu.sm.app.dto.SideDish;
import edu.sm.app.service.MenuService;
import edu.sm.app.service.ToppingService;
import edu.sm.app.service.SideDishService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Slf4j
@ActiveProfiles("dev")
class MenuTests {

    @Autowired
    MenuService menuService;
    
    @Autowired
    ToppingService toppingService;
    
    @Autowired
    SideDishService sideDishService;

    @Test
    void testMenuServiceIntegration() throws Exception {
        log.info("=== 메뉴 서비스 통합 테스트 시작 ===");
        
        // 1. 모든 메뉴 조회 테스트
        List<Menu> allMenus = menuService.get();
        log.info("전체 메뉴 개수: {}", allMenus.size());
        

    }

    


}
