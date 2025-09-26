package edu.sm.controller;

import edu.sm.app.dto.Cate;
import edu.sm.app.dto.Product;
import edu.sm.app.service.CateService;
import edu.sm.app.service.CustService;
import edu.sm.app.service.ProductService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor

public class ProductController {

    final ProductService productService;
    final BCryptPasswordEncoder bCryptPasswordEncoder;
    final StandardPBEStringEncryptor standardPBEStringEncryptor;
    final CateService cateService;

    String dir="product/";


    @RequestMapping("/add")
    public String add(Model model) throws Exception {
        model.addAttribute("cate",cateService.get());
        model.addAttribute("center",dir+"add");
        return "index";
    }
    @RequestMapping("/productdetail")
    public String productdetail(Model model, @RequestParam("id") int id) throws Exception {
        Product product = null;
        product = productService.get(id);
        model.addAttribute("cate",cateService.get());
                model.addAttribute("p", product);
        model.addAttribute("left", dir+"left");
        model.addAttribute("center", dir+"productdetail");
        log.info(product.getProductId()+","+product.getProductName());
        return "index";
    }

    @RequestMapping("/get")
    public String get(Model model) throws Exception {
        List<Product> list = null;

        list = productService.get();
        model.addAttribute("plist", list);
        model.addAttribute("center",dir+"get");
        return "index";
    }

    @RequestMapping("/updateimpl")
    public String updateimpl(Model model, Product product) throws Exception {
        // 디버깅: 컨트롤러가 받은 product 객체의 내용을 확인합니다.
        log.info("Update Request Data: {}", product.toString());
        productService.modify(product);
        return "redirect:/product/productdetail?id="+product.getProductId();
    }

    @RequestMapping("/delete")
    public String delete(Model model, Product product, @RequestParam("id") int id) throws Exception {
        productService.remove(id);
        return "redirect:/product/get";
    }


    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, Product product) throws Exception {
        productService.register(product);
        return "redirect:/product/get";
    }




}