package eud.sm.app.repository;

import eud.sm.app.dto.Marker;
import eud.sm.app.dto.Search;
import eud.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Repository
@Mapper
public interface SearchRepository extends SmRepository<Search, Integer>{
}
