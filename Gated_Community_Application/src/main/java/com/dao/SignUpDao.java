package com.dao;

import com.model.Resident;
import com.util.DBConnection;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class SignUpDao {

    public boolean save(Resident resident) {
        if (resident == null) return false;
        Transaction tx = null;
        try (Session session = DBConnection.getConnection().openSession()) {
            tx = session.beginTransaction();
            session.persist(resident);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }
}
