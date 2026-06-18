package com.util;

import com.model.Complaint;
import com.model.Resident;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class DBConnection {

    private static SessionFactory sessionFactory;

    public static synchronized SessionFactory getConnection() {
        if (sessionFactory == null) {
            try {
                Configuration cfg = new Configuration();
                cfg.addAnnotatedClass(Complaint.class);
                cfg.addAnnotatedClass(Resident.class);
                cfg.configure("hibernate.cfg.xml");
                sessionFactory = cfg.buildSessionFactory();
            } catch (Exception e) {
                throw new IllegalStateException(
                    "Failed to connect to database. Check that MySQL is running and " +
                    "the credentials in hibernate.cfg.xml are correct.", e);
            }
        }
        return sessionFactory;
    }
}
