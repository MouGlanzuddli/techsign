package com.mycompany.adminscreen.service;

import com.mycompany.adminscreen.dao.LoginHistoryDAO;
import com.mycompany.adminscreen.model.LoginHistory;
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