import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String enteredOtp = request.getParameter("otp");

        PrintWriter out = response.getWriter();

        // OTP verification
        if (!enteredOtp.equals(SendOTPServlet.otpCode)) {
            out.print("Invalid OTP. Try again.");
            return;
        }

        try {
            // Load Derby JDBC Driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish connection
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

            // Insert user data into database
            String query = "INSERT INTO userss (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
            
            out.print("Registration Successful!");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error registering user.");
        }
    }
}
