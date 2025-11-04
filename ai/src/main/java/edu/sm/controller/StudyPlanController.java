package edu.sm.controller;

import edu.sm.app.dto.StudyPlan;
import edu.sm.app.service.StudyPlanService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class StudyPlanController {

    private final StudyPlanService studyPlanService;

    @PostMapping("/study-planner")
    public ResponseEntity<String> generatePlan(@RequestBody String prompt) throws Exception {
        System.out.println("Received prompt for study plan: " + prompt);
        studyPlanService.generateAndSavePlan(prompt);
        return ResponseEntity.ok("스터디 계획이 성공적으로 생성되어 달력에 추가되었습니다.");
    }

    @GetMapping("/study-plans")
    public List<StudyPlan> getStudyPlans() throws Exception {
        return studyPlanService.getAllPlans();
    }

    @PutMapping("/study-plans/{id}")
    public ResponseEntity<Void> updatePlan(@PathVariable int id, @RequestBody StudyPlan plan) throws Exception {
        plan.setId(id);
        studyPlanService.modify(plan);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/study-plans/{id}")
    public ResponseEntity<Void> deletePlan(@PathVariable int id) throws Exception {
        studyPlanService.remove(id);
        return ResponseEntity.ok().build();
    }
}
