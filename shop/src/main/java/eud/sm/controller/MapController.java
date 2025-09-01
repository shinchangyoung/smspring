package eud.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/map")
public class MapController {

    String dir="map/";

    @RequestMapping("")
    public String main(Model model) {
        model.addAttribute("center",dir+"center");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/map1")
    public String map1(Model model) {
        model.addAttribute("center",dir+"map1");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/map2")
    public String map2(Model model) {
        model.addAttribute("center",dir+"map2");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/map3")
    public String map3(Model model) {
        model.addAttribute("center",dir+"map3");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/map4")
    public String map4(Model model) {
        model.addAttribute("center",dir+"map4");
        model.addAttribute("left",dir+"left");
        return "index";
    }
}