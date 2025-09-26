package edu.sm.cust;



import edu.sm.app.dto.Cust;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class CustTest {

    @Autowired
    edu.sm.service.CustService custService;

    @Test
    void getall() {
        List<Cust> list = null;
        try {
            list = custService.get();
            list.forEach(cust -> log.info(cust.toString()));
            log.info("Select All End ------------------------------------------");

        } catch (Exception e) {
            log.info("Error Test ...");
            e.printStackTrace();
        }
    }
//
//
//    @Test
//    void insert() {
//        Cust cust = Cust.builder().custId("id65").custName("홍인철").custPwd("pwd65").build();
//        try {
//            custService.register(cust);
//            log.info("Insert End ------------------------------------------");
//        } catch (Exception e) {
//            log.info("Error Insert Test ...");
//            e.printStackTrace();
//        }
//    }


//    @Test
//    void update() {
//        Cust cust = Cust.builder().custId("id65").custName("이태준").custPwd("5555").build();
//        try {
//            custService.modify(cust);
//            log.info("Update End ------------------------------------------");
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }
//    @Test
//    void get2() {
//        Cust cust = null;
//        try {
//            cust = custService.get("id65");
//            log.info(cust.toString());
//            log.info("Select End ------------------------------------------");
//
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }
//    @Test
//    void delete() {
//        try {
//            custService.remove("id65");
//            log.info("Delete End ------------------------------------------");
//        } catch (Exception e) {
//            log.info("Error Test ...");
//            e.printStackTrace();
//        }
//    }
}