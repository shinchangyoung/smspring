package edu.sm.controller;

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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class LoginController {

    final CustService custService;
    final BCryptPasswordEncoder bCryptPasswordEncoder;
    final StandardPBEStringEncryptor standardPBEStringEncryptor;
    
    // 로그인 카운트용 별도 logger
    private static final org.slf4j.Logger loginCountLogger = org.slf4j.LoggerFactory.getLogger("edu.sm.controller.LoginCountLogger");

    @RequestMapping("/updatepwd")
    public String updatepwd(Model model) {
        model.addAttribute("center","updatepwd");
        model.addAttribute("left","left");
        return "index";
    }
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

        if(result != true){
            model.addAttribute("msg","비밀번호가 틀렸습니다.");
            model.addAttribute("center","error");
            return "index";
        }
        cust.setCustAddr(standardPBEStringEncryptor.encrypt(cust.getCustAddr()));
        cust.setCustPwd(bCryptPasswordEncoder.encode(cust.getCustPwd()));
        custService.modify(cust);
        return "redirect:/custinfo?id=" + cust.getCustId();
    }
    @RequestMapping("/login")
    public String add(Model model) {
        model.addAttribute("center","login");
        model.addAttribute("left","left");
        return "index";
    }
    @RequestMapping("/loginimpl")
    public String loginimpl(Model model, @RequestParam("id") String id,
                            @RequestParam("pwd") String pwd,
                            HttpSession httpSession) throws Exception {
        Cust dbCust = custService.get(id);
        if(dbCust != null && bCryptPasswordEncoder.matches(pwd, dbCust.getCustPwd())){
            httpSession.setAttribute("cust",dbCust);
            // login.log에 사용자 정보 기록
            log.info(dbCust.getCustId()+","+dbCust.getCustName());
            
            // logincount.log에 카운트 기록
            try {
                Path countLogPath = Paths.get("C:/smspring/logs/logincount.log");
                int loginCount = 0;
                if (Files.exists(countLogPath)) {
                    List<String> lines = Files.readAllLines(countLogPath);
                    // 빈 줄 제외한 실제 로그 라인 수 계산
                    loginCount = (int) lines.stream().filter(line -> !line.trim().isEmpty()).count();
                }
                // 다음 카운트 값을 기록
                loginCountLogger.info(String.valueOf(loginCount + 1));
            } catch (IOException e) {
                loginCountLogger.info("1");
                e.printStackTrace();  // 디버깅용
            }
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

    @RequestMapping("/updatepwdimpl")
    public String updatepwdimpl(Model model, @RequestParam("pwd") String pwd,
                            @RequestParam("new_pwd") String new_pwd,
                            HttpSession httpSession) throws Exception {
        Cust sessionCust = (Cust) httpSession.getAttribute("cust");
        boolean result = bCryptPasswordEncoder.matches(pwd, sessionCust.getCustPwd());
        if(result != true){
            model.addAttribute("msg","비밀번호가 틀렸습니다.");
        }else{
            // 신규 비밀번호 변경
            sessionCust.setCustPwd(bCryptPasswordEncoder.encode(new_pwd));
            custService.modify(sessionCust);
            model.addAttribute("msg","비밀번호가 수정 되었습니다.");
        }
        model.addAttribute("center","updatepwd");

        return "index";
    }
}