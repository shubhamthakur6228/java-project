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
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/SaveOrderServlet")
public class SaveOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Read JSON request
            JsonObject jsonData = JsonParser.parseReader(request.getReader()).getAsJsonObject();
            String name = jsonData.get("name").getAsString();
            String email = jsonData.get("email").getAsString();
            String address = jsonData.get("address").getAsString();
            String paymentMethod = jsonData.get("paymentMethod").getAsString();
            String totalAmount = jsonData.get("totalAmount").getAsString();
            int orderId = jsonData.get("orderId").getAsInt();

            // Database Connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:3306/fooddelivery", "app", "app");

            // Insert Order into Database
            String query = "INSERT INTO pending_orders (order_id, name, email, address, payment_method, total_amount) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, orderId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setString(5, paymentMethod);
            ps.setString(6, totalAmount);
            ps.executeUpdate();

            out.println("Order successfully placed!");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
