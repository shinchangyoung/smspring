package edu.sm.app.dto.repository;


import edu.sm.app.dto.Menu;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


import java.util.List;

@Repository
@Mapper
public interface MenuRepository extends SmRepository<Menu, String> {

}