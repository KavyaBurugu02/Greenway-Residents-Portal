package com.dao;

import com.model.Resident;
import com.util.DBConnection;
import org.hibernate.Session;

public class LoginDao {

    public Resident authenticate(String username, String password) {
        if (username == null || password == null) return null;
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Resident where userName = ?1 and password = ?2", Resident.class)
                    .setParameter(1, username)
                    .setParameter(2, password)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean usernameExists(String username) {
        if (username == null) return false;
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Resident where userName = ?1", Resident.class)
                    .setParameter(1, username)
                    .uniqueResult() != null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
