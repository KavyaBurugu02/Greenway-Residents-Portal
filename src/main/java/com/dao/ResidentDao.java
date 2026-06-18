package com.dao;

import com.model.Complaint;
import com.util.ComplaintStatus;
import com.util.DBConnection;
import org.hibernate.Session;

import java.util.Collections;
import java.util.List;

public class ResidentDao {

    public List<Complaint> getResolvedComplaints(int residentId) {
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Complaint where userId = ?1 and status = ?2", Complaint.class)
                    .setParameter(1, residentId)
                    .setParameter(2, ComplaintStatus.RESOLVED)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
