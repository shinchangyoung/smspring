package edu.sm.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/springai1")
public class SpringAI1Controller {

    String dir="springai1/";

    @RequestMapping("")
    public String main(Model model) {
        model.addAttribute("center",dir+"center");
        model.addAttribute("left",dir+"left");
        return "index";
    }

    @RequestMapping("/ai1")
    public String ai1(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai1");
        return "index";
    }
    @RequestMapping("/ai2")
    public String ai2(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai2");
        return "index";
    }
    @RequestMapping("/ai3")
    public String ai3(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai3");
        return "index";
    }
    @RequestMapping("/ai4")
    public String ai4(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai4");
        return "index";
    }
    @RequestMapping("/ai41")
    public String ai41(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai41");
        return "index";
    }
    @RequestMapping("/ai5")
    public String ai5(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai5");
        return "index";
    }
    @RequestMapping("/ai6")
    public String ai6(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai6");
        return "index";
    }
    @RequestMapping("/ai7")
    public String ai7(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai7");
        return "index";
    }
    @RequestMapping("/ai8")
    public String ai8(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai8");
        return "index";
    }
    @RequestMapping("/ai9")
    public String ai9(Model model) {
        model.addAttribute("left",dir+"left");
        model.addAttribute("center",dir+"ai9");
        return "index";
    }


}