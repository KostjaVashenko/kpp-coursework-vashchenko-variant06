package ua.edu.nupp.kpp.server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBUtil {

    private static final String URL =
            "jdbc:mysql://localhost:3306/road_defects";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private DBUtil() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Одноразова перевірка для п. 10.3 Інструкції Етапу 1 (після успішного запуску метод main видалити):
    public static void main(String[] args) {
        try (Connection connection = getConnection()) {
            System.out.println("Підключення до MySQL успішне.");
        } catch (SQLException e) {
            System.out.println("Помилка підключення до MySQL:");
            System.out.println(e.getMessage());
        }
    }
}