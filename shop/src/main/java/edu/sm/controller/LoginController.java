package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.Cust;
import edu.sm.app.service.CustService;
import jakarta.servlet.http.HttpSession;
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
@RequiredArgsConstructor
public class LoginController {

    final CustService custService;
    final BCryptPasswordEncoder bCryptPasswordEncoder;
    final StandardPBEStringEncryptor standardPBEStringEncryptor;

    @RequestMapping("/register")
    public String main(Model model) {
        model.addAttribute("center","register");
        model.addAttribute("left","left");
        return "index";
    }
    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, Cust cust) throws Exception {
        cust.setCustPwd(bCryptPasswordEncoder.encode(cust.getCustPwd()));
        cust.setCustAddr(standardPBEStringEncryptor.encrypt(cust.getCustAddr()));
        custService.register(cust);
        return "redirect:/login";
    }

    @RequestMapping("/login")
    public String add(Model model) {
        model.addAttribute("center","login");
        model.addAttribute("left","left");
        return "index";
    }

    @RequestMapping("/custinfo")
    public String custinfo(Model model, @RequestParam("id") String id) throws Exception {
        Cust dbCust = custService.get(id);
        dbCust.setCustAddr(standardPBEStringEncryptor.decrypt(dbCust.getCustAddr()));
        if(dbCust != null){
            model.addAttribute("cust",dbCust);
        }
        model.addAttribute("center","custinfo");
        return "index";
    }

    @RequestMapping("/updatecustinfo")
    public String updatecustinfo(Model model, Cust cust) throws Exception {
        boolean result = bCryptPasswordEncoder.matches(cust.getCustPwd(),
                custService.get(cust.getCustId()).getCustPwd());
        System.out.println(result);
        if(result != true){
            model.addAttribute("msg","비밀번호가 일치하지 않습니다.");
            model.addAttribute("center","error");
            return "index";
        }
        cust.setCustAddr(standardPBEStringEncryptor.encrypt(cust.getCustAddr()));
        cust.setCustPwd(standardPBEStringEncryptor.encrypt(cust.getCustPwd()));
        custService.modify(cust);

        model.addAttribute("center","login");
        model.addAttribute("msg","로그인 실패!!!");
        return "redirect:/";
    }

    @RequestMapping("/loginimpl")
    public String loginimpl(Model model, @RequestParam("id") String id,
                            @RequestParam("pwd") String pwd,
                            HttpSession httpSession) throws Exception {
        Cust dbCust = custService.get(id);
        if(dbCust != null && bCryptPasswordEncoder.matches(pwd, dbCust.getCustPwd())){
            httpSession.setAttribute("cust",dbCust);
            return "redirect:/";
        }
        model.addAttribute("center","login");
        model.addAttribute("msg","로그인 실패!!!");
        return "index";
    }
    @RequestMapping("/logout")
    public String logout(Model model, HttpSession httpSession) throws Exception {
        if(httpSession != null){
            httpSession.invalidate();
        }
        return "redirect:/";
    }
}