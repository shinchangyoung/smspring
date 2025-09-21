package edu.sm.app.service;

import edu.sm.app.dto.Phone;
import edu.sm.app.repository.PhoneRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j
public class PhoneService implements SmService<Phone, String> {
    final PhoneRepository phoneRepository;

    @Override
    public void register(Phone phone) throws Exception {
        phoneRepository.insert(phone);
    }

    @Override
    public void modify(Phone phone) throws Exception {
        phoneRepository.update(phone);
    }

    @Override
    public void remove(String s) throws Exception {
    }

    @Override
    public List<Phone> get() throws Exception {
        return List.of();
    }

    @Override
    public Phone get(String s) throws Exception {
        return null;
    }

    // 월별 브랜드별 매출 합계 조회
    public List<Map<String, Object>> getSalesByBrand() throws Exception {
        return phoneRepository.getSalesByBrand();
    }

    // 월별 브랜드별 매출 평균 조회
    public List<Map<String, Object>> getAverageSalesByBrand() throws Exception {
        return phoneRepository.getAverageSalesByBrand();
    }
}