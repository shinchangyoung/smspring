package edu.sm.app.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class LogoService1 {
    public void save1(String data){
        log.info(data);
    }
}
