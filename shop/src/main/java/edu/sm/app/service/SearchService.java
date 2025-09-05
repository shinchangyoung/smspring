package edu.sm.app.service;

import edu.sm.app.dto.Search;
import edu.sm.app.repository.SearchRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SearchService implements SmService<Search, Integer> {

    final SearchRepository searchRepository;

    @Override
    public void register(Search search) throws Exception {

    }

    @Override
    public void modify(Search search) throws Exception {

    }

    @Override
    public void remove(Integer integer) throws Exception {

    }


    public List<Search> findByAddtAndType(int type) throws Exception {
        return searchRepository.findByAddrAndType(type);
    }


    @Override
    public List<Search> get() throws Exception {
        return searchRepository.selectAll();
    }

    @Override
    public Search get(Integer integer) throws Exception {
        return searchRepository.select(integer);
    }
}
