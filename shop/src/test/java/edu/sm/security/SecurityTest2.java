package edu.sm.security;

import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEByteEncryptor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class SecurityTest2 {
    @Autowired
    StandardPBEStringEncryptor encoder;
    @Test
    void contestLoads(){
        String txt = "서울시 강남구 역삼동 171번지";
        String enTxt = encoder.encrypt(txt);
        log.info("txt: {}", txt);
        log.info("enTxt: {}", enTxt);
        String decTxt = encoder.decrypt(enTxt);
        log.info("decTxt: {}", decTxt);

    }
}
