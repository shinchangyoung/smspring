package edu.sm.controller;

import edu.sm.app.dto.Shop;
import edu.sm.app.repository.ShopRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.Random;

@RestController
@RequiredArgsConstructor
@Slf4j
public class MapRestController {

    final ShopRepository shopRepository;

    double lat;
    double lon;

    @RequestMapping("/getshops")
    public Object getshops(@RequestParam(value = "cateNo", required = false) Integer cateNo) throws Exception {
        if (cateNo == null) {
            return Collections.emptyList();
        }
        List<Shop> list = shopRepository.findByCateNo(cateNo);
        return list;
    }

    @RequestMapping("/getlatlng")
    public Object getlatlng() throws Exception {
        JSONObject jsonObject = new JSONObject();
        //36.800209, 127.074968
        Random r = new Random();
        double lat = 36.800209 + r.nextDouble(0.005);
        double lng = 127.074968 + r.nextDouble(0.005);
        jsonObject.put("lat", lat);
        jsonObject.put("lng", lng);
        // {lat:xxxxx, lng:xxxxxx}
        return jsonObject;
    }




}
