package edu.sm.controller;

import edu.sm.app.service.PhoneService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/chart")
@RequiredArgsConstructor
public class ChartController {

    String dir="chart/";
    final PhoneService phoneService;

    @RequestMapping("")
    public String main(Model model) {
        model.addAttribute("center",dir+"center");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/chart1")
    public String chart1(Model model) {
        model.addAttribute("center",dir+"chart1");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/chart2")
    public String chart2(Model model) {
        model.addAttribute("center",dir+"chart2");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/chart3")
    public String chart3(Model model) {
        try {
            // 월별 브랜드별 매출 합계 데이터
            List<Map<String, Object>> salesData = phoneService.getSalesByBrand();
            model.addAttribute("salesData", salesData);
            
            // 월별 브랜드별 매출 평균 데이터
            List<Map<String, Object>> averageData = phoneService.getAverageSalesByBrand();
            model.addAttribute("averageData", averageData);
            
            log.info("Sales Data: {}", salesData);
            log.info("Average Data: {}", averageData);
            
        } catch (Exception e) {
            log.error("Error loading chart3 data", e);
            model.addAttribute("salesData", List.of());
            model.addAttribute("averageData", List.of());
        }
        
        model.addAttribute("center",dir+"chart3");
        model.addAttribute("left",dir+"left");
        return "index";
    }
    @RequestMapping("/chart4")
    public String chart4(Model model) {
        model.addAttribute("center",dir+"chart4");
        model.addAttribute("left",dir+"left");
        return "index";
    }
}