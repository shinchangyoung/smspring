package eud.sm.app.repository;

import eud.sm.app.dto.Content;
import eud.sm.app.dto.Search;
import eud.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface ContentRepository extends SmRepository<Content, Integer> {
    List<Content> findByAddrAndType(int type);
}
