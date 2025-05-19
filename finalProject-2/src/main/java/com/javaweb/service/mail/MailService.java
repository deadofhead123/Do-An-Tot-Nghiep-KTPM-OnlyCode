package com.javaweb.service.mail;

import com.javaweb.constant.SystemConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Service
@PropertySource("classpath:application.properties")
public class MailService implements IMailService {
    @Autowired
    private JavaMailSender mailSender; // Must config host of sender in file "application.properties" to avoid error "not found bean JavaMailSender"

    @Value("${spring.mail.username}")
    private String emailOfShop;

    // Scope: get the domain name of website
    // Must use this method, don't use static url ("localhost:8080") --> To deploy
    @Override
    public String generateURL(HttpServletRequest request){
        String siteURL = request.getRequestURL().toString(); // Example: "localhost:8080/forgot-password";

        return siteURL.replace(request.getServletPath(), ""); // ServletPath: after domain name. Example: "/forgot-password", "/home"
    }

    @Override
    public Boolean sendEmailAboutResetPassword(String recipentEmail, String url) throws MessagingException, UnsupportedEncodingException {
        // Tools to send email
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);

        // Sender, receiver
        helper.setFrom(emailOfShop, SystemConstant.NAME_OF_SHOP);
        helper.setTo(recipentEmail);

        // Content
        String content = "<p>Chào bạn.</p>"
                + "<p>Bạn đã yêu cầu đặt lại mật khẩu.</p>"
                + "<p>Hãy nhấn vào link dưới đây:</p>"
                + "<a href=" + url + ">Đặt lại mật khẩu</a>"
                + "<p><b>Lưu ý</b>: Link chỉ có hiệu lực trong <b>" + SystemConstant.RESET_TOKEN_EXPIRED + " ngày </b></p>";

        helper.setSubject("Đặt lại mật khẩu");
        helper.setText(content, true);
        mailSender.send(mimeMessage);

        return true;
    }

    @Override
    public Boolean replyContact(String recipentEmail, String content, Date createdAt) throws MessagingException, UnsupportedEncodingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);

        helper.setFrom(emailOfShop, SystemConstant.NAME_OF_SHOP);
        helper.setTo(recipentEmail);
        helper.setSubject("Trả lời liên hệ");

        DateTimeFormatter formatPattern = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        LocalDateTime convertDateToLDT = LocalDateTime.ofInstant(createdAt.toInstant(), ZoneId.systemDefault());
        String[] formattedTime = convertDateToLDT.format(formatPattern).split(" ");

        String date = formattedTime[0];
        String time = formattedTime[1];

        String context = "<p>Chào bạn.</p>"
                + "<p>" + "Chúng tôi xin trả lời thắc mắc bạn đã gửi vào ngày <b>" + date + "</b>, lúc <b>" + time + "</b> như sau:</p>"
                + "<p>" + content + "</p>";

        helper.setText(context, true);

        mailSender.send(mimeMessage);

        return true;
    }

    @Override
    public Boolean lockOrUnlockAccount(String recipentEmail, Integer action) throws MessagingException, UnsupportedEncodingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);

        helper.setFrom(emailOfShop, SystemConstant.NAME_OF_SHOP);
        helper.setTo(recipentEmail);

        String context;

        if(action == 0){
            helper.setSubject("Khóa tài khoản");

            context = "<p>Chào bạn.</p>"
                    + "<p>Tài khoản của bạn đã bị khóa.</p>"
                    + "<p>Vui lòng liên hệ với quản trị viên để mở lại</p>";
        }
        else{
            helper.setSubject("Mở khóa tài khoản");

             context = "<p>Chào bạn.</p>"
                    + "<p>Tài khoản của bạn đã được mở khóa.</p>"
                    + "<p>Bạn có thể đăng nhập hệ thống bình thường</p>";
        }

        helper.setText(context, true);
        mailSender.send(mimeMessage);

        return true;
    }
}
