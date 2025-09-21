package edu.sm.controller;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import edu.sm.app.service.PhoneService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ChartRestController {

    @Value("${app.dir.logsdirRead}")
    String dir;

    private final PhoneService phoneService;

    @RequestMapping("/chart3")
    public Object chart3() {
        try {
            // 1. Fetch all data
            List<Map<String, Object>> totalDbResult = phoneService.getSalesByBrand();
            List<Map<String, Object>> avgDbResult = phoneService.getAverageSalesByBrand();

            // 2. Get all unique months and sort them
            List<Integer> months = totalDbResult.stream()
                    .map(item -> ((Number) item.get("month")).intValue())
                    .distinct()
                    .sorted()
                    .collect(Collectors.toList());

            // Create month categories for the chart axis
            List<String> categories = months.stream()
                                            .map(month -> month + "월")
                                            .collect(Collectors.toList());

            // 3. Process both total and average sales data
            List<Map<String, Object>> totalSalesSeries = processSalesData(totalDbResult, months);
            List<Map<String, Object>> averageSalesSeries = processSalesData(avgDbResult, months);

            // 4. Combine into a single response object
            Map<String, Object> response = new HashMap<>();
            response.put("categories", categories);
            response.put("totalSalesSeries", totalSalesSeries);
            response.put("averageSalesSeries", averageSalesSeries);

            log.info("Chart3 API Response: {}", response);
            return response;
        } catch (Exception e) {
            log.error("Error in chart3 API", e);
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "데이터를 가져오는 중 오류가 발생했습니다.");
            return errorResponse;
        }
    }

    private List<Map<String, Object>> processSalesData(List<Map<String, Object>> dbResult, List<Integer> months) {
        // Group data by phone name
        Map<String, List<Map<String, Object>>> groupedData = dbResult.stream()
                .collect(Collectors.groupingBy(item -> (String) item.get("phone_name")));

        List<Map<String, Object>> seriesList = new ArrayList<>();

        // For each phone, create a series
        for (Map.Entry<String, List<Map<String, Object>>> entry : groupedData.entrySet()) {
            Map<String, Object> series = new HashMap<>();
            series.put("name", entry.getKey());

            // Create a map of month -> value for quick lookup
            Map<Integer, Object> monthlyDataMap = entry.getValue().stream()
                    .collect(Collectors.toMap(
                            item -> ((Number) item.get("month")).intValue(),
                            item -> item.get("value"),
                            (v1, v2) -> v1 // in case of duplicate months for a phone, which shouldn't happen with the current SQL
                    ));

            // Build the data list, ordered by months. Insert 0 if no data for a month.
            List<Object> data = months.stream()
                    .map(month -> monthlyDataMap.getOrDefault(month, 0))
                    .collect(Collectors.toList());
            
            series.put("data", data);
            seriesList.add(series);
        }
        return seriesList;
    }

    @RequestMapping("/chart2_1")
    public Object chart2_1() throws Exception {
        //[[],[]]
        JSONArray jsonArray = new JSONArray();
        String [] nation = {"Kor","Eng","Jap","Chn","Usa"};
        Random random = new Random();
        for(int i=0;i<nation.length;i++){
            JSONArray jsonArray1 = new JSONArray();
            jsonArray1.add(nation[i]);
            jsonArray1.add(random.nextInt(100)+1);
            jsonArray.add(jsonArray1);
        }
        return jsonArray;
    }
    @RequestMapping("/chart2_2")
    public Object chart2_2() throws Exception {
        //{cate:[],data:[]}
        JSONObject jsonObject = new JSONObject();
        String arr [] = {"0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90+"};
        jsonObject.put("cate",arr);
        Random random = new Random();
        JSONArray jsonArray = new JSONArray();
        for(int i=0;i<arr.length;i++){
            jsonArray.add(random.nextInt(100)+1);
        }
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }

    @RequestMapping("/chart2_3")
    public Object chart2_3() throws Exception {

            CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(dir + "click.log"), "UTF-8"));
            String[] line;
            reader.readNext();  // 헤더 건너뜀

            StringBuffer sb = new StringBuffer();
            while ((line = reader.readNext()) != null) {
                sb.append(line[2] + " ");

            }
            return sb.toString();
    }

    @RequestMapping("/chart1")
    public Object chart1() throws Exception {
        // []
        JSONArray jsonArray = new JSONArray();

        // {}
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        JSONObject jsonObject3 = new JSONObject();
        jsonObject1.put("name","Korea");
        jsonObject2.put("name","Japan");
        jsonObject3.put("name","China");
        // []
        JSONArray data1Array = new JSONArray();
        JSONArray data2Array = new JSONArray();
        JSONArray data3Array = new JSONArray();

        Random random = new Random();
        for(int i=0;i<12;i++){
            data1Array.add(random.nextInt(100)+1);
            data2Array.add(random.nextInt(100)+1);
            data3Array.add(random.nextInt(100)+1);
        }
        jsonObject1.put("data",data1Array);
        jsonObject2.put("data",data2Array);
        jsonObject3.put("data",data3Array);

        jsonArray.add(jsonObject1);
        jsonArray.add(jsonObject2);
        jsonArray.add(jsonObject3);
        return  jsonArray;
    }
}






