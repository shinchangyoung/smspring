package edu.sm.cust;

import edu.sm.app.dto.Cust;
import edu.sm.app.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class deleteTests {

    @Autowired
    CustService custService;
    @Test
    void contextLoads() throws Exception{
        Cust cust  = Cust.builder()
                        .custId("id06")
                        .build();
        // custService.remove(cust);

        log.info(custService.get("id06").toString());
    }

}
