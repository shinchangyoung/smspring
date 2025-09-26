package edu.sm.app.repository;



import edu.sm.app.dto.Cust;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CustRepository extends SmRepository<Cust, String> {
}