package edu.sm.app.repository;


import com.github.pagehelper.Page;
import edu.sm.app.dto.Cust;
import edu.sm.app.dto.CustSearch;
import edu.sm.app.dto.Player;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PlayerRepository extends SmRepository<Player, String> {
}