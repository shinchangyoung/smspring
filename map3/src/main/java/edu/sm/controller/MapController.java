package edu.sm.controller;

import edu.sm.app.dto.Shop;
import edu.sm.app.service.ShopService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("/map")
@RequiredArgsConstructor
public class MapController {

    String dir="map/";


    final ShopService shopService;


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


    @RequestMapping("/goshop")
    public String goshop(Model model, @RequestParam("target") int target) throws Exception {
        Shop shop = shopService.get(target);
        model.addAttribute("shop",shop);
        model.addAttribute("center",dir+"goshop");
        model.addAttribute("left",dir+"left");
        return "index";
    }


}