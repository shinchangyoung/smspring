package edu.sm.controller;


import edu.sm.app.dto.Hotel;
import edu.sm.app.dto.ReviewClassification;
import edu.sm.app.springai.service2.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/ai2")
@Slf4j
@RequiredArgsConstructor
public class Ai2Controller {

  final private AiServiceListOutputConverter aiServiceloc;
  final private AiServiceBeanOutputConverter aiServiceboc;
  final private AiServiceMapOutputConverter aiServicemoc;
  final private AiServiceParameterizedTypeReference aiServiceptr;
  final private AiServiceSystemMessage aiServicesm;
  final private AiServiceFewShot aiServiceFewShot;
  final private AiServiceshop aiServiceshop;


  // ##### 요청 매핑 메소드 #####
  @RequestMapping(value = "/list-output-converter")
  public List<String> listOutputConverter(@RequestParam("city") String city) {
    List<String> hotelList = aiServiceloc.listOutputConverterHighLevel(city);
    // List<String> hotelList = aiServiceloc.listOutputConverterHighLevel(city);
    return hotelList;
  }
  @RequestMapping(value = "/bean-output-converter")
  public Hotel beanOutputConverter(@RequestParam("city") String city) {
    //Hotel hotel = aiService.beanOutputConverterLowLevel(city);
    Hotel hotel = aiServiceboc.beanOutputConverterHighLevel(city);
    return hotel;
  }
  @RequestMapping(value = "/map-output-converter")
  public Map<String, Object> mapOutputConverter(@RequestParam("hotel") String hotel) {
    //Map<String, Object> hotelInfo = aiServicemoc.mapOutputConverterLowLevel(hotel);
    Map<String, Object> hotelInfo = aiServicemoc.mapOutputConverterHighLevel(hotel);
    return hotelInfo;
  }
  @RequestMapping(value = "/generic-bean-output-converter")
  public List<Hotel> genericBeanOutputConverter(@RequestParam("cities") String cities) {
    //List<Hotel> hotelList = aiService.genericBeanOutputConverterLowLevel(cities);
    List<Hotel> hotelList = aiServiceptr.genericBeanOutputConverterHighLevel(cities);
    return hotelList;
  }
  @RequestMapping(value = "/system-message")
  public ReviewClassification beanOutputConverter2(@RequestParam("review") String review) {
    ReviewClassification reviewClassification = aiServicesm.classifyReview(review);
    return reviewClassification;
  }
  @RequestMapping("/few-shop-prompt")
  public String fewShotPrompt(@RequestParam("question") String question){
    try {
      // DB 기반 AI 서비스로 변경

      return aiServiceshop.processOrder(question);
    } catch (Exception e) {
      log.error("주문 처리 중 오류 발생", e);
      return "{\"error\": \"주문 처리 중 오류가 발생했습니다.\"}";
    }
  }

  @RequestMapping("/menu")
  public String getMenu() throws Exception {
    return aiServiceshop.getMenuAsString();
  }

  // 기존 하드코딩 방식도 유지 (필요시 사용)
  @RequestMapping("/few-shop-prompt-original")
  public String fewShotPromptOriginal(@RequestParam("question") String question){
    return aiServiceFewShot.fewShotPrompt(question);
  }


}
