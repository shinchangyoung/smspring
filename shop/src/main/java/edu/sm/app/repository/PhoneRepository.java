package edu.sm.app.repository;

import edu.sm.app.dto.Phone;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface PhoneRepository extends SmRepository<Phone, String> {
    List<Map<String, Object>> getSalesByBrand();
    List<Map<String, Object>> getAverageSalesByBrand();
}
