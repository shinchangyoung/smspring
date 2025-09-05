package edu.sm.app.repository;

import edu.sm.app.dto.Shop;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ShopRepository extends SmRepository<Shop, Integer> {
    List<Shop> findByCateNo(Integer cateNo);
}