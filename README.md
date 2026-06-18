# Greenway Residents Portal

A full-stack Java web application that lets residents of a gated community raise and track maintenance complaints, while administrators manage and update their status — all through a clean, role-based web interface.

---

## Overview

Managing maintenance requests in a gated community typically means phone calls, sticky notes, or WhatsApp messages that get lost. This project replaces that with a lightweight portal where:

- **Residents** submit complaints, edit them while they're open, and see their history once resolved.
- **Admins** get a single view of every complaint across the community and can move each one through an Open → In Progress → Resolved workflow.

The application is built with plain Jakarta Servlets and JSP — no heavyweight framework — which keeps the architecture easy to follow and demonstrates a solid understanding of the Java EE request/response lifecycle.

---

## Features

**Resident**
- Register and sign in with role-based session management
- Submit a complaint with category, subject, description, and flat number
- Edit or cancel open complaints
- View resolved complaints separately in a history page

**Admin**
- Dedicated admin dashboard (account seeded directly in the database — no public admin signup by design)
- View all complaints across all residents in one table
- Update complaint status: Open, In Progress, Resolved

**General**
- Session protection on every page — unauthenticated requests redirect to login
- Server-side validation on all forms with user-friendly error messages
- Consistent UI across all pages from a single shared stylesheet

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Web tier | Jakarta Servlet 6.0, JSP |
| ORM | Hibernate 6.4 (Jakarta Persistence) |
| Database | MySQL 8 |
| Build | Maven 3 |
| Server | Apache Tomcat 10+ |
| Frontend | HTML5, CSS3 (no JavaScript frameworks) |

---

## Architecture

```
Browser
  └── HTTP request
        └── Tomcat (Servlet container)
              └── Servlet  (@WebServlet annotation, no web.xml)
                    ├── DAO layer  (Hibernate Session)
                    │     └── MySQL
                    └── JSP  (view, rendered server-side)
```

The application follows a straightforward MVC pattern:

- **Model** — `Resident`, `Complaint` (JPA entities)
- **View** — JSP pages under `src/main/webapp/`
- **Controller** — Servlets under `com.servlet`
- **DAO** — Thin data-access classes under `com.dao`, one per domain concept

There is no Spring or CDI. Dependency wiring is manual and deliberate — it makes the request flow easy to trace for anyone reading the code.

---

## Project Structure

```
GatedCommuApp/
├── src/
│   └── main/
│       ├── java/com/
│       │   ├── dao/                   # Data access (Hibernate sessions)
│       │   │   ├── AdminDao.java
│       │   │   ├── ComplaintDao.java
│       │   │   ├── LoginDao.java
│       │   │   ├── ResidentDao.java
│       │   │   └── SignUpDao.java
│       │   ├── model/                 # JPA entities
│       │   │   ├── Complaint.java
│       │   │   └── Resident.java
│       │   ├── servlet/               # Request handlers
│       │   │   ├── LoginServlet.java
│       │   │   ├── LogoutServlet.java
│       │   │   ├── SignUpServlet.java
│       │   │   ├── ComplaintServlet.java
│       │   │   ├── ResidentViewComplaintsServlet.java
│       │   │   ├── ComplaintsHistoryServlet.java
│       │   │   ├── UpdateComplaintServlet.java
│       │   │   ├── SaveComplaintServlet.java
│       │   │   ├── DeleteComplaintServlet.java
│       │   │   ├── AdminViewComplaintsServlet.java
│       │   │   ├── LoadStatusServlet.java
│       │   │   └── SaveStatusServlet.java
│       │   └── util/
│       │       ├── DBConnection.java  # Singleton SessionFactory
│       │       └── ComplaintStatus.java
│       ├── resources/
│       │   └── hibernate.cfg.xml.template   # Copy → hibernate.cfg.xml and add credentials
│       └── webapp/
│           ├── assets/css/style.css
│           ├── header.jspf            # Shared nav bar (included by all pages)
│           ├── statusBadge.jspf       # Reusable status badge fragment
│           ├── index.jsp              # Login
│           ├── signup.jsp
│           ├── residentDashboard.jsp
│           ├── adminDashboard.jsp
│           ├── raiseComplaint.jsp
│           ├── residentViewComplaints.jsp
│           ├── complaintsHistory.jsp
│           ├── allComplaints.jsp
│           ├── updateComplaint.jsp
│           ├── updateStatus.jsp
│           └── error.jsp
├── schema.sql                         # Database creation + seed notes
├── pom.xml
└── README.md
```

---

## Getting Started

### Prerequisites

- JDK 17 or later
- Maven 3.6+
- MySQL 8
- Apache Tomcat 10.1+

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/GatedCommuApp.git
cd GatedCommuApp
```

### 2. Set up the database

```bash
mysql -u root -p < schema.sql
```

This creates the `gated_community` database. Hibernate will create the tables automatically on first run.

### 3. Configure database credentials

```bash
cp src/main/resources/hibernate.cfg.xml.template src/main/resources/hibernate.cfg.xml
```

Open `hibernate.cfg.xml` and replace `YOUR_DB_USERNAME` and `YOUR_DB_PASSWORD` with your MySQL credentials. This file is in `.gitignore` and will never be committed.

### 4. Build

```bash
mvn clean package
```

This produces `target/GatedCommuApp.war`.

### 5. Deploy

Copy the WAR to your Tomcat `webapps/` directory:

```bash
cp target/GatedCommuApp.war $CATALINA_HOME/webapps/
```

Then start Tomcat and open `http://localhost:8080/GatedCommuApp/`.

### 6. Create an admin account

Admin accounts cannot be registered through the UI. Insert one directly:

```sql
USE gated_community;
INSERT INTO residents (userName, password, email, phoneNumber, role)
VALUES ('admin', 'yourpassword', 'admin@greenway.com', '9999999999', 'Admin');
```

Sign in with those credentials to access the admin dashboard.

---

## Screenshots

> Add screenshots here after deployment. Suggested captures:
> - Login page
> - Resident dashboard
> - Raise a complaint form
> - My complaints table with status badges
> - Admin complaints view
> - Update status form

---

## Design Decisions

**No admin self-registration** — allowing users to select their own role on a public form is a common security mistake. Admin access requires a manual database insert, which keeps privilege escalation off the table.

**No web.xml** — all servlet mappings use `@WebServlet` annotations, which is the current Jakarta EE standard and keeps configuration close to the code it describes.

**No JavaScript framework** — the UI is server-rendered JSP. The goal was to demonstrate the Java EE stack clearly, not to add frontend complexity that obscures it.

**Hibernate `hbm2ddl.auto=update`** — fine for development; a production deployment would use a migration tool like Flyway.

---

## Future Enhancements

- Password hashing (BCrypt) — currently stored as plain text, which is acceptable for a local demo but must be addressed before any real deployment
- Flyway or Liquibase for proper schema migrations
- Pagination on the complaints tables
- Email notifications when complaint status changes
- File attachment support for complaints (photos of the issue)
- REST API layer to support a mobile client

---

## Author

Feel free to connect or reach out:

- **GitHub: KavyaBurugu02(https://github.com/KavyaBurugu02)
- **LinkedIn: www.linkedin.com/in/kavyaburugu



---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
