package edu.sm.security;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.security.auth.kerberos.EncryptionKey;

@SpringBootTest
@Slf4j
public class SecurityTest {
    @Autowired
    BCryptPasswordEncoder encoder;
    @Test
    void contestLoads(){
        String pwd = "111111";
        String encPwd = encoder.encode(pwd);
        log.info("pwd: {}",  pwd);
        log.info("encPwd: {}", encPwd);
        boolean matches = encoder.matches(pwd, encPwd);
        log.info("matches:{}", matches);
    }
}
