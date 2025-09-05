package edu.sm.app.service;

import edu.sm.app.dto.Shop;
import edu.sm.app.repository.ShopRepository;
import edu.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ShopService implements SmService<Shop, Integer> {

    final ShopRepository shopRepository;


    @Override
    public void register(Shop shop) throws Exception {
        shopRepository.insert(shop);
    }

    @Override
    public void modify(Shop shop) throws Exception {
        shopRepository.update(shop);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        shopRepository.delete(integer);
    }

    @Override
    public List<Shop> get() throws Exception {
        return shopRepository.selectAll();
    }

    public List<Shop> findByCateNo(Integer cateNo) throws Exception {
        return shopRepository.findByCateNo(cateNo);
    }


    @Override
    public Shop get(Integer integer) throws Exception {
        return shopRepository.select(integer);
    }
}