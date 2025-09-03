package eud.sm.app.service;

import eud.sm.app.dto.Search;
import eud.sm.app.repository.SearchRepository;
import eud.sm.common.frame.SmService;
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

    @Override
    public List<Search> get() throws Exception {
        return searchRepository.selectAll();
    }

    @Override
    public Search get(Integer integer) throws Exception {
        return searchRepository.select(integer);
    }
}
