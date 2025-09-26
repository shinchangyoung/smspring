package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.Random;

@Controller
@Slf4j
public class MainController {
    @Value("${app.url.websocketurl}")
    String websocketurl;

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Test...");
        Random random = new Random();

       // log.info(""+random.nextInt(100)+1);
        // Database 데이터를 가지고 온다.
        return "index";
    }

    @RequestMapping("/pic")
    public String pic(Model model) {
        model.addAttribute("center","pic");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/audio")
    public String audio(Model model) {
        model.addAttribute("center","audio");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/wt1")
    public String wt1(Model model) {
        model.addAttribute("center","wt1");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/wt2")
    public String wt2(Model model) {
        model.addAttribute("center","wt2");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/wt3")
    public String wt3(Model model) {
        model.addAttribute("center","wt3");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/inquiry")
    public String inquiry(Model model) {
        model.addAttribute("center","inquiry");
        model.addAttribute("left","left");
        return "index";
    }


}