package edu.sm.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.Cust;
import edu.sm.app.dto.CustSearch;
import edu.sm.app.dto.Player;
import edu.sm.app.repository.PlayerRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PlayerService implements SmService<Player, String> {

    final PlayerRepository playerRepository;

    @Override
    public void register(Player player) throws Exception {
        playerRepository.insert(player);
    }

    @Override
    public void modify(Player player) throws Exception {
        playerRepository.update(player);
    }

    @Override
    public void remove(String s) throws Exception {
        playerRepository.delete(s);
    }

    @Override
    public List<Player> get() throws Exception {
        return playerRepository.selectAll();
    }

    @Override
    public Player get(String s) throws Exception {
        return playerRepository.select(s);
    }
}