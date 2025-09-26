package edu.sm.app.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class LogoService3 {
    public void save3(String data){
        log.info(data);
    }
}
