package view;

import dao.UserDAO;
import model.User;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

public class RegisterForm extends JFrame {
    private JTextField txtUsername;
    private JPasswordField txtPassword;
    private JPasswordField txtConfirmPassword;
    private JTextField txtEmail;
    private JTextField txtFullName;
    private JTextField txtPhone;
    private JComboBox<String> cmbRole;
    private JButton btnRegister;
    private JButton btnCancel;
    private JLabel lblError;

    public RegisterForm() {
        setTitle("Đăng ký tài khoản");
        setSize(400, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);

        int row = 0;

        panelAdd(panel, gbc, row++, "Username:", txtUsername = new JTextField(20));
        panelAdd(panel, gbc, row++, "Password:", txtPassword = new JPasswordField(20));
        panelAdd(panel, gbc, row++, "Confirm Password:", txtConfirmPassword = new JPasswordField(20));
        panelAdd(panel, gbc, row++, "Email:", txtEmail = new JTextField(20));
        panelAdd(panel, gbc, row++, "Phone:", txtPhone = new JTextField(20));
        panelAdd(panel, gbc, row++, "Full Name:", txtFullName = new JTextField(20));

        gbc.gridx = 0; gbc.gridy = row; gbc.anchor = GridBagConstraints.EAST;
        panel.add(new JLabel("Role:"), gbc);
        gbc.gridx = 1; gbc.anchor = GridBagConstraints.WEST;
        cmbRole = new JComboBox<>(new String[]{"Candidate", "Employer"});
        panel.add(cmbRole, gbc);
        row++;

        gbc.gridx = 0; gbc.gridy = row++; gbc.gridwidth = 2;
        lblError = new JLabel("", JLabel.CENTER);
        lblError.setForeground(Color.RED);
        panel.add(lblError, gbc);

        btnRegister = new JButton("Đăng ký");
        gbc.gridy = row++;
        panel.add(btnRegister, gbc);

        btnCancel = new JButton("Hủy");
        gbc.gridy = row;
        panel.add(btnCancel, gbc);

        add(panel);

        // Xử lý sự kiện
        btnRegister.addActionListener(e -> registerUser());
        btnCancel.addActionListener(e -> dispose());
    }

    private void panelAdd(JPanel panel, GridBagConstraints gbc, int row, String label, JComponent component) {
        gbc.gridx = 0; gbc.gridy = row; gbc.anchor = GridBagConstraints.EAST;
        panel.add(new JLabel(label), gbc);
        gbc.gridx = 1; gbc.anchor = GridBagConstraints.WEST;
        panel.add(component, gbc);
    }

    private void registerUser() {
        String username = txtUsername.getText().trim();
        String password = new String(txtPassword.getPassword());
        String confirmPassword = new String(txtConfirmPassword.getPassword());
        String email = txtEmail.getText().trim();
        String phone = txtPhone.getText().trim();
        String fullName = txtFullName.getText().trim();
        String role = cmbRole.getSelectedItem().toString();

        // Kiểm tra dữ liệu đầu vào
        if (username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() ||
            email.isEmpty() || fullName.isEmpty() || phone.isEmpty()) {
            lblError.setText("Vui lòng điền đầy đủ thông tin!");
            return;
        }

        if (!password.equals(confirmPassword)) {
            lblError.setText("Mật khẩu không trùng khớp!");
            return;
        }

        if (password.length() < 6) {
            lblError.setText("Mật khẩu phải có ít nhất 6 ký tự!");
            return;
        }

        try (Connection conn = getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            if (userDAO.isUsernameExists(username)) {
                lblError.setText("Username đã tồn tại!");
                return;
            }

            if (userDAO.isEmailExists(email)) {
                lblError.setText("Email đã được sử dụng!");
                return;
            }

            // Hash mật khẩu
            String passwordHash = hashPassword(password);

            // Chuyển role sang roleId (giả sử Candidate = 2, Employer = 3)
            int roleId = role.equalsIgnoreCase("Employer") ? 3 : 2;

            Date now = new Date();

            User user = new User();
            user.setUsername(username);
            user.setPasswordHash(passwordHash);
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setRoleId(roleId);
            user.setEmailVerified(false);
            user.setPhoneVerified(false);
            user.setAvatarUrl(""); // Có thể thêm chọn ảnh sau
            user.setStatus("ACTIVE");
            user.setCreatedAt(now);
            user.setUpdatedAt(now);

            if (userDAO.register(user)) {
                JOptionPane.showMessageDialog(this, "Đăng ký thành công!");
                dispose();
            } else {
                lblError.setText("Đăng ký thất bại!");
            }

        } catch (SQLException ex) {
            lblError.setText("Lỗi kết nối DB: " + ex.getMessage());
        } catch (Exception ex) {
            lblError.setText("Lỗi: " + ex.getMessage());
        }
    }

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/jobsearch";
        String user = "root";
        String pass = ""; // Đổi theo MySQL của bạn
        return DriverManager.getConnection(url, user, pass);
    }

    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashed = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashed) sb.append(String.format("%02x", b));
        return sb.toString();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new RegisterForm().setVisible(true));
    }
}
