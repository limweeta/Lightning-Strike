package model;
 
import java.util.Date;
import java.util.Properties;
 


import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

 
/**
 * A utility class for sending e-mail messages
 * @author www.codejava.net
 *
 */
public class EmailUtility {
    public static void sendEmail(String host, String port,
            final String userName, final String password, String toAddress,
            String subject, String message) throws AddressException,
            MessagingException {
 
        // sets SMTP server properties
    	
  
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true");


	// Create a new session and removing the previous new Authenticator portion.

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        });
 	
	try {
		Message msg = new MimeMessage(session);
		
		msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());

        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");

        
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);

        msg.setContent(multipart);

        // sends the e-mail
        Transport.send(msg);
		// Setting Content-Type does not seem to be required.
		// I guess it is determined from the file type
		
        	
        	// Test values taken in (remove)
   		System.out.println("host:" + host);
    		System.out.println("port:" + port);
    		System.out.println("userName:" + userName);
    		System.out.println("password:" + password);
    		System.out.println("toAddress:" + toAddress);
    		System.out.println("subject:" + subject);
    		System.out.println("message:" + message);
    		System.out.println("host:" + props.get("mail.smtp.host"));
	}catch (MessagingException e) {
		throw new RuntimeException(e);
	}
    }
}