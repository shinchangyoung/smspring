package eud.sm.app.service;

import eud.sm.app.dto.Content;
import eud.sm.app.dto.Marker;
import eud.sm.app.dto.Search;
import eud.sm.app.repository.ContentRepository;
import eud.sm.app.repository.MarkerRepository;
import eud.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContentService implements SmService<Content, Integer> {

    final ContentRepository contentRepository;

    public List<Content> findByAddtAndType(int type) throws Exception {
        return contentRepository.findByAddrAndType(type);
    }

    @Override
    public void register(Content content) throws Exception {

    }

    @Override
    public void modify(Content content) throws Exception {

    }

    @Override
    public void remove(Integer integer) throws Exception {

    }

    @Override
    public List<Content> get() throws Exception {
        return contentRepository.selectAll();
    }

    @Override
    public Content get(Integer integer) throws Exception {
        return contentRepository.select(integer);
    }
}