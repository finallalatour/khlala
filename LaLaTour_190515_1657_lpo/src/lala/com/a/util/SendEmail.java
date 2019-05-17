package lala.com.a.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
 public static void SendId(String email, String pwd) {

  String host     = "smtp.naver.com";
  final String user   = "black8594";
  final String password  = "gkdlspzps00";

  String to     = email;

  
  // Get the session object
  Properties props = new Properties();
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.auth", "true");

  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
   protected PasswordAuthentication getPasswordAuthentication() {
    return new PasswordAuthentication(user, password);
   }
  });

  // Compose the message
  try {
   MimeMessage message = new MimeMessage(session);
   message.setFrom(new InternetAddress(user));
   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

   // Subject
   message.setSubject("LalaTour 비밀번호 입니다.");
   
   // Text
   message.setText(pwd);

   // send the message
   Transport.send(message);
   System.out.println("성공적으로 발송되었습니다.");

  } catch (MessagingException e) {
   e.printStackTrace();
   System.out.println("발송 실패하였습니다.");
  }
 }
}
