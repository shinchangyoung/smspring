package edu.sm.app.repository;

import edu.sm.app.dto.Splayer;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SplayerRepository extends SmRepository<Splayer, String> {
    List<Splayer> search(Splayer splayer);
    List<Splayer> selectWithSort(Splayer splayer);
    List<Splayer> findByIds(Splayer splayer);

    // [추가] 새로운 choose 쿼리를 위한 메서드
    List<Splayer> selectPlayersChoose(Splayer splayer);
}