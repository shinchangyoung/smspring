package edu.sm.app.service;

import edu.sm.app.dto.Content;
import edu.sm.app.repository.ContentRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContentService implements SmService<Content, Integer> {

    final ContentRepository contentRepository;

    public List<Content> findByTargetAndType(int target, int type) throws Exception {
        return contentRepository.findByTargetAndType(target, type);
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