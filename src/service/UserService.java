package service;

import dal.UserDao;
import model.User;
import java.sql.Connection;
import java.util.List;

public class UserService {
    private UserDao userDao;

    public UserService(Connection connection) {
        this.userDao = new UserDao(connection);
    }

    public boolean addUser(User user) throws Exception {
        return userDao.insertUser(user);
    }

    public List<User> listUsers() throws Exception {
        return userDao.getAllUsers();
    }

    public User getUserById(int id) throws Exception {
        return userDao.getUserById(id);
    }

    public boolean updateUser(User user) throws Exception {
        return userDao.updateUser(user);
    }

    public boolean deleteUser(int id) throws Exception {
        return userDao.deleteUser(id);
    }

    public boolean checkEmailExists(String email) throws Exception {
        return userDao.checkEmailExists(email);
    }

    public User login(String email, String password) {
        return userDao.login(email, password);
    }
} 