package edu.sm.app.repository;

import edu.sm.app.dto.StudyPlan;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface StudyPlanRepository extends SmRepository<StudyPlan, Integer> {
}
