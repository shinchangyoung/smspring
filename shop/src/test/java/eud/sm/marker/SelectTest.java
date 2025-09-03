package eud.sm.marker;


import eud.sm.app.dto.Content;
import eud.sm.app.dto.Marker;
import eud.sm.app.dto.Search;
import eud.sm.app.repository.ContentRepository;
import eud.sm.app.service.ContentService;
import eud.sm.app.service.MarkerService;
import eud.sm.app.service.SearchService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class SelectTests {
    @Autowired
    MarkerService markerService;

    @Autowired
    ContentService contentService;

    @Autowired
    SearchService searchService;
    @Test
    void contextLoads() {
        try {
//            List<Marker> list = markerService.get();
//            list.forEach(System.out::println);
//
//            Marker marker = markerService.get(101);
//            log.info(marker.toString());
//
//            List<Marker> list2 = markerService.findByLoc(200);
//            list2.forEach((data)->{log.info(data.toString());});

            List<Content> list2 = contentService.findByAddtAndType()
            list2.forEach((data)->{log.info(data.toString());});


//            List<Content> list2 = contentService.get();
//            list2.forEach(System.out::println);

//            Search search = searchService.get(10);
//            log.info(search.toString());
//
//            List<Search> list3 = searchService.get();
//            list3.forEach(System.out::println);
//
//            Content content = contentService.get(101);
//            log.info(content.toString());





        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}