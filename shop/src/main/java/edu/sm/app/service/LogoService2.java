package edu.sm.app.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class LogoService2 {
    public void save2(String data){
        log.info(data);
    }
}
