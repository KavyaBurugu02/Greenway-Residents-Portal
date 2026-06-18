package com.dao;

import com.model.Complaint;
import com.util.DBConnection;
import org.hibernate.Session;

import java.util.Collections;
import java.util.List;

public class AdminDao {

    public List<Complaint> getAllComplaints() {
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Complaint order by complaintId desc", Complaint.class)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
