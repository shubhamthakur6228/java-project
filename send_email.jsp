<%@ page import="java.util.Properties, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
<%@ page import="java.io.*" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String paymentAmount = request.getParameter("paymentAmount");
    String orderSummary = request.getParameter("orderSummary");

// SMTP Configuration
    final String senderEmail = "shubhamthakurr31@gmail.com";  // Replace with your email
    final String senderPassword = "shubham@0987";  // Replace with your email password
    String smtpHost = "smtp.gmail.com"; // Change as needed (e.g., for Outlook: smtp.office365.com)
    
    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", smtpHost);
    props.put("mail.smtp.port", "587"); // TLS port

    Session s = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(senderEmail, senderPassword);
        }
    });

    try {
        Message message = new MimeMessage(s);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Order Confirmation - FoodExpress");

        String emailContent = "<h2>Thank you for your order, " + name + "!</h2>";
        emailContent += "<p>Your order has been successfully placed.</p>";
        emailContent += "<p><strong>Order Details:</strong></p>";
        emailContent += "<p>" + orderSummary + "</p>";
        emailContent += "<p><strong>Total Payment:</strong> " + paymentAmount + "</p>";
        emailContent += "<p><strong>Delivery Address:</strong> " + address + "</p>";
        emailContent += "<p><strong>Estimated Delivery Time:</strong> 45 minutes</p>";
        emailContent += "<p>We hope you enjoy your meal!</p>";

        message.setContent(emailContent, "text/html");

        Transport.send(message);

        // Redirect to order confirmation page after sending email
        response.sendRedirect("order-confirmation.html?status=success");
    } catch (MessagingException e) {
        e.printStackTrace();
        response.sendRedirect("order-confirmation.html?status=error");
    }
%>
