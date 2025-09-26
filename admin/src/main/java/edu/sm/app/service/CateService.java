package edu.sm.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.Cate;
import edu.sm.app.dto.Cust;
import edu.sm.app.dto.CustSearch;
import edu.sm.app.repository.CateRepository;
import edu.sm.app.repository.CustRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CateService implements SmService<Cate, Integer> {
    final CateRepository cateRepository;

    @Override
    public void register(Cate cate) throws Exception {
        cateRepository.insert(cate);
    }

    @Override
    public void modify(Cate cate) throws Exception {
        cateRepository.update(cate);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        cateRepository.delete(integer);
    }


    @Override
    public List<Cate> get() throws Exception {
        return cateRepository.selectAll();
    }

    @Override
    public Cate get(Integer integer) throws Exception {
        return cateRepository.select(integer);
    }

}