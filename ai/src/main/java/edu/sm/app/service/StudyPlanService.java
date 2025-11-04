package edu.sm.app.service;

import edu.sm.app.dto.StudyPlan;
import edu.sm.app.repository.StudyPlanRepository;
import edu.sm.app.springai.service2.AiServiceBeanOutputConverter;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StudyPlanService implements SmService<StudyPlan, Integer> {


    private final StudyPlanRepository studyPlanRepository;
    private final AiServiceBeanOutputConverter aiService; // AI 서비스 주입

    // AI를 통해 스터디 계획을 생성하고 DB에 저장하는 메소드
    public void generateAndSavePlan(String prompt) throws Exception {
        // AI에게 프롬프트를 전달하여 StudyPlan 리스트를 생성하도록 요청
        List<StudyPlan> plans = aiService.getStudyPlan(prompt);

        // AI가 생성한 각 계획을 DB에 저장
        for (StudyPlan plan : plans) {
            studyPlanRepository.insert(plan);
        }
    }

    // 모든 스터디 계획을 DB에서 조회하는 메소드
    public List<StudyPlan> getAllPlans() throws Exception {
        return studyPlanRepository.selectAll();
    }

    @Override
    public void register(StudyPlan studyPlan) throws Exception {
        studyPlanRepository.insert(studyPlan);
    }

    @Override
    public void modify(StudyPlan studyPlan) throws Exception {
        studyPlanRepository.update(studyPlan);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        studyPlanRepository.delete(integer);
    }

    @Override
    public List<StudyPlan> get() throws Exception {
        return studyPlanRepository.selectAll();
    }

    @Override
    public StudyPlan get(Integer integer) throws Exception {
        return studyPlanRepository.select(integer);
    }
}
