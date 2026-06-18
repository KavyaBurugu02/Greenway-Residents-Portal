package com.model;

import jakarta.persistence.*;

@Entity
@Table(name = "complaints")
public class Complaint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int complaintId;

    private int userId;
    private String category;
    private String subject;
    private String description;
    private int flatNo;
    private String status;

    public Complaint() {}

    public Complaint(int userId, String category, String subject, String description, int flatNo) {
        this.userId = userId;
        this.category = category;
        this.subject = subject;
        this.description = description;
        this.flatNo = flatNo;
    }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getFlatNo() { return flatNo; }
    public void setFlatNo(int flatNo) { this.flatNo = flatNo; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
