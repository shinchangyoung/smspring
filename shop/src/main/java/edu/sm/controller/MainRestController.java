package edu.sm.controller;

import edu.sm.app.dto.Content;
import edu.sm.app.dto.Marker;
import edu.sm.app.dto.Search;
import edu.sm.app.service.*;
import edu.sm.util.FileUploadUtil;
import edu.sm.util.WeatherUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class MainRestController {

    final LogoService1 logoService1;
    final LogoService2 logoService2;
    final LogoService3 logoService3;
    final LogoService4 logoService4;


    @Value("${app.key.wkey}")
    String wkey;

    @RequestMapping("/getwt1")
    public Object getwt1(@RequestParam("loc") String loc) throws IOException, ParseException {
        return WeatherUtil.getWeather(loc,wkey);
    }

    @RequestMapping("/savedata")
    public Object savedata(@RequestParam("data") String data1) throws IOException {
        log.info(data1);
        return "OK";
    }

    @RequestMapping("/savedata1")
    public Object savedata1(@RequestParam("data") String data) throws IOException {
        logoService1.save1(data);
        return "OK";
    }

    @RequestMapping("/savedata2")
    public Object savedata2(@RequestParam("data") String data) throws IOException {
        logoService2.save2(data);
        return "OK";
    }

    @RequestMapping("/savedata3")
    public Object savedata3(@RequestParam("data") String data) throws IOException {
        logoService3.save3(data);
        return "OK";
    }

    @RequestMapping("/savedata4")
    public Object savedata4(@RequestParam("data") String data) throws IOException {
        logoService4.save4(data);
        return "OK";
    }


    @RequestMapping("/saveaudio")
    public Object saveaudio(@RequestParam("file") MultipartFile file) throws IOException {
        FileUploadUtil.saveFile(file, "C:/smspring/audios/");
        return "OK";
    }
    @RequestMapping("/saveimg")
    public Object saveimg(@RequestParam("file") MultipartFile file) throws IOException {
        FileUploadUtil.saveFile(file, "C:/smspring/imgs/");
        return "OK";
    }
}






