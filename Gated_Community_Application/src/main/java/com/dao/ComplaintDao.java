package com.dao;

import com.model.Complaint;
import com.util.DBConnection;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.Collections;
import java.util.List;

public class ComplaintDao {

    public List<Complaint> getByResident(int residentId) {
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Complaint where userId = ?1 order by complaintId desc", Complaint.class)
                    .setParameter(1, residentId)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public Complaint getById(int complaintId) {
        try (Session session = DBConnection.getConnection().openSession()) {
            return session.createSelectionQuery(
                    "from Complaint where complaintId = ?1", Complaint.class)
                    .setParameter(1, complaintId)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean save(Complaint complaint) {
        if (complaint == null) return false;
        Transaction tx = null;
        try (Session session = DBConnection.getConnection().openSession()) {
            tx = session.beginTransaction();
            session.persist(complaint);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Complaint complaint) {
        if (complaint == null) return false;
        Transaction tx = null;
        try (Session session = DBConnection.getConnection().openSession()) {
            tx = session.beginTransaction();
            session.merge(complaint);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(Complaint complaint) {
        if (complaint == null) return false;
        Transaction tx = null;
        try (Session session = DBConnection.getConnection().openSession()) {
            tx = session.beginTransaction();
            session.remove(session.contains(complaint) ? complaint : session.merge(complaint));
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }
}
