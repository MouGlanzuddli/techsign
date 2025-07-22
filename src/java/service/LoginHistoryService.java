package service;

import dao.LoginHistoryDAO;

import model.LoginHistory;
import java.util.List;

public class LoginHistoryService {
    private LoginHistoryDAO dao;

    public LoginHistoryService(LoginHistoryDAO dao) {
        this.dao = dao;
    }

    public void log(LoginHistory history) throws Exception {
        dao.add(history);
    }

    public List<LoginHistory> getByUser(int userId) throws Exception {
        return dao.getByUserId(userId);
    }

    public List<LoginHistory> getAll() throws Exception {
        return dao.getAll();
    }
}