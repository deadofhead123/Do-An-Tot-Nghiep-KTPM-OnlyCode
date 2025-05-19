package com.javaweb.service.mail;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Date;

public interface IMailService {
    public String generateURL(HttpServletRequest request);
    public Boolean sendEmailAboutResetPassword(String recipentEmail, String url) throws MessagingException, UnsupportedEncodingException;
    public Boolean replyContact(String recipentEmail, String content, Date createdAt) throws MessagingException, UnsupportedEncodingException;
    public Boolean lockOrUnlockAccount(String recipentEmail, Integer action) throws MessagingException, UnsupportedEncodingException;
}
