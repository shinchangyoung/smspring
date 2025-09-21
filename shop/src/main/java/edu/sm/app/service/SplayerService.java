//package edu.sm.app.service;
//
//import edu.sm.app.dto.Splayer;
//import edu.sm.app.repository.SplayerRepository;
//import edu.sm.common.frame.SmService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//@RequiredArgsConstructor
//public class SplayerService implements SmService<Splayer, String> {
//
//    final SplayerRepository splayerRepository;
//
//    @Override
//    public void register(Splayer splayer) throws Exception {
//        splayerRepository.insert(splayer);
//    }
//
//    @Override
//    public void modify(Splayer splayer) throws Exception {
//        splayerRepository.update(splayer);
//    }
//
//    @Override
//    public void remove(String s) throws Exception {
//        splayerRepository.delete(s);
//    }
//
//    @Override
//    public List<Splayer> get() throws Exception {
//        return splayerRepository.selectAll();
//    }
//
//    @Override
//    public Splayer get(String s) throws Exception {
//        return splayerRepository.select(s);
//    }
//
//    public List<Splayer> search(Splayer splayer) throws Exception {
//        return splayerRepository.search(splayer);
//    }
//
//    public List<Splayer> getWithSort(Splayer splayer) throws Exception {
//        return splayerRepository.selectWithSort(splayer);
//    }
//
//    public List<Splayer> getByIds(Splayer splayer) throws Exception {
//        return splayerRepository.findByIds(splayer);
//    }
//
//    // [추가] 새로운 choose 쿼리를 위한 서비스
//    public List<Splayer> getPlayersChoose(Splayer splayer) throws Exception {
//        return splayerRepository.selectPlayersChoose(splayer);
//    }
//}