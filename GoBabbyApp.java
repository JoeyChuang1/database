import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.List;

public class GoBabbyApp {
    public static void main(String[] args) {
        GoBabbyApp program = new GoBabbyApp();
        program.Begin();
        if (program.Stop == 1) {
            try {
                program.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return;
        }
        try {
            program.AskDate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (program.Stop == 1) {
            try {
                program.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return;
        }
    }

    Connection con;
    Statement statement;
    List<String> PractitionerIDs = new ArrayList<>();
    public String ThisPracID;
    public int Stop;
    List<String> Appointments = new ArrayList<>();
    List<String> Display1 = new ArrayList<>();
    List<String> Notes = new ArrayList<>();
    List<String> Tests = new ArrayList<>();
    List<String> ThisTestID = new ArrayList<>();
    List<String> ThisNodeID = new ArrayList<>();

    public GoBabbyApp() {
        try {
            Load();
        } catch (SQLException e) {
            System.out.println("Error while loading data");
        }
    }

    public void AskDate() throws SQLException {
        PreparedStatement AppointmentsPrep = con.prepareStatement("SELECT APPOINTMENT.ATIME, 'P' as TYPE, MOTHER.MNAME, MOTHER.HEACCARD, PREGNANCY.PREGID, APPOINTMENT.APPOINTMENTID\n" +
                "FROM Appointment JOIN PREGNANCY on PREGNANCY.PRACID = APPOINTMENT.PRACID AND PREGNANCY.COUPLEID = APPOINTMENT.COUPLEID\n" +
                "    JOIN COUPLE C2 on PREGNANCY.COUPLEID = C2.COUPLEID\n" +
                "    JOIN MOTHER on MOTHER.HEACCARD = C2.HEACCARD\n" +
                "where ? = APPOINTMENT.ADATE AND APPOINTMENT.PRACID = ? \n" +
                "UNION\n" +
                "SELECT  APPOINTMENT.ATIME, 'B' as TYPE, MOTHER.MNAME, MOTHER.HEACCARD, PREGNANCY.PREGID, APPOINTMENT.APPOINTMENTID\n" +
                "FROM Appointment JOIN PREGNANCY on PREGNANCY.BACKUPID = APPOINTMENT.PRACID AND PREGNANCY.COUPLEID = APPOINTMENT.COUPLEID\n" +
                "                 JOIN COUPLE C2 on PREGNANCY.COUPLEID = C2.COUPLEID\n" +
                "                 JOIN MOTHER on MOTHER.HEACCARD = C2.HEACCARD\n" +
                "where ? = APPOINTMENT.ADATE AND APPOINTMENT.PRACID = ?\n" +
                "ORDER BY ATIME;");
        PreparedStatement query1 = con.prepareStatement("SELECT Notes.SDATE, Notes.STIME, Notes.CONTENT\n" +
                "FROM Pregnancy JOIN Notes on PREGNANCY.PregID = NOTES.PREGID\n" +
                "where Pregnancy.PregID = ?\n" +
                "ORDER BY SDATE DESC, STIME DESC");
        PreparedStatement query2 = con.prepareStatement("\n" +
                "SELECT Test.PrecDate, Test.Type, Test.Result\n" +
                "FROM Test join Pregnancy on Pregnancy.PregID = Test.PregID\n" +
                "where PREGNANCY.PREGID = ?\n" +
                "ORDER BY TEST.PrecDate DESC");
        PreparedStatement query3 = con.prepareStatement("INSERT INTO Notes (AppointmentID, content, Stime, SDate, NID, PracID, PregID) VALUES\n" +
                "    (?, ?, current_time , current_date , ?, ?, ?);");
        PreparedStatement query4 = con.prepareStatement("INSERT INTO Test (TestID, Type, PrecDate, sampleTestDate, LabDate, Result, TechID, PracID, PregID) VALUES\n" +
                "        (?, ?, current_date , current_date , NULL, NULL, 'Tech001', ?, ?)");
        while (true) {
            Scanner input = new Scanner(System.in);
            System.out.println("Please enter the date for appointment list[E] to exit");
            String date = input.nextLine();
            if (date.equals("E")) {
                Stop = 1;
                return;
            } else if (date.equals("D")) {
                continue;
            } else {
                Appointments.clear();
                Display1.clear();
                AppointmentsPrep.setDate(1, Date.valueOf(date));
                AppointmentsPrep.setString(2, this.ThisPracID);
                AppointmentsPrep.setDate(3, Date.valueOf(date));
                AppointmentsPrep.setString(4, this.ThisPracID);
                ResultSet rs = AppointmentsPrep.executeQuery();
                while (rs.next()) {
                    String answer = rs.getTime("ATIME") + " "
                            + rs.getString("TYPE") + " "
                            + rs.getString("MNAME") + " "
                            + rs.getString("HEACCARD") + " "
                            + rs.getString("PREGID") + " "
                            + rs.getString("APPOINTMENTID");
                    String answer2 = rs.getTime("ATIME") + " "
                            + rs.getString("TYPE") + " "
                            + rs.getString("MNAME") + " "
                            + rs.getString("HEACCARD");
                    Display1.add(answer2);
                    Appointments.add(answer);
                }
                if (Appointments.size() == 0) {
                    continue;
                } else {
                    while (true) {
                        for (int i = 0; i < Display1.size(); i++) {
                            System.out.println(i + 1 + ". " + Display1.get(i));
                        }
                        Scanner input2 = new Scanner(System.in);
                        System.out.println("Please Enter the appointment number that you would like to work on.\n" +
                                "[E] to exit [D] to go back to another date :");
                        String num1 = input2.nextLine();
                        if (num1.equals("E")) {
                            Stop = 1;
                            return;
                        } else if (num1.equals("D")) {
                            break;
                        } else {
                            int num2 = Integer.parseInt(num1);
                            while (true) {
                                String[] split = this.Appointments.get(num2 - 1).split(" ");
                                System.out.println("For " + split[2] + " " + split[3]);
                                System.out.println("1. Review notes \n" +
                                        "2. Review tests \n" +
                                        "3. Add a note \n" +
                                        "4. Prescribe a test \n" +
                                        "5. Go back to Appointments ");
                                Scanner input3 = new Scanner(System.in);
                                System.out.println("Enter you choice: ");
                                String num4 = input3.nextLine();
                                int num5 = Integer.parseInt(num4);
                                if (num5 == 1) {
                                    Notes.clear();
                                    query1.setString(1, split[4]);
                                    ResultSet rs1 = query1.executeQuery();
                                    while (rs1.next()) {
                                        String content = rs1.getString("CONTENT");
                                        String new_content = content.substring(0, Math.min(content.length(), 50));
                                        String answer = rs1.getDate("SDATE") + "  "
                                                + rs1.getTime("STIME") + "   "
                                                + new_content + " ";
                                        Notes.add(answer);
                                    }
                                    for (String a : Notes) {
                                        System.out.println(a);
                                    }
                                } else if (num5 == 2) {
                                    Tests.clear();
                                    query2.setString(1, split[4]);
                                    ResultSet rs2 = query2.executeQuery();
                                    while (rs2.next()) {
                                        String detail = rs2.getString("RESULT");
                                        if (detail == null) {
                                            detail = "PENDING...";
                                        }
                                        String new_detail = detail.substring(0, Math.min(detail.length(), 50));
                                        String answer3 = rs2.getString("PRECDATE") + " " + "[" + rs2.getString("TYPE") + "]"
                                                + " " + new_detail;
                                        Tests.add(answer3);
                                    }
                                    for (String b : Tests) {
                                        System.out.println(b);
                                    }
                                } else if (num5 == 3) {
                                    String NoteID = "Note";
                                    int NoteIDSize = this.ThisNodeID.size() + 1;
                                    String newID = NoteID + NoteIDSize;
                                    this.ThisNodeID.add(newID);
                                    Scanner input4 = new Scanner(System.in);
                                    System.out.println("Please type your observation: ");
                                    String num6 = input4.nextLine();
                                    query3.setString(1, split[5]);
                                    query3.setString(2, num6);
                                    query3.setString(3, newID);
                                    query3.setString(4, this.ThisPracID);
                                    query3.setString(5, split[4]);
                                    query3.executeUpdate();
                                } else if (num5 == 4) {
                                    String testID = "Test";
                                    int testIDsize = this.ThisTestID.size() + 1;
                                    String newID = testID + testIDsize;
                                    Scanner input4 = new Scanner(System.in);
                                    System.out.println("Please enter the type of test: ");
                                    String num6 = input4.nextLine();
                                    query4.setString(1, newID);
                                    query4.setString(2, num6);
                                    query4.setString(3, this.ThisPracID);
                                    query4.setString(4, split[4]);
                                    query4.executeUpdate();
                                } else {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public void close() throws SQLException {
        this.statement.close();
        this.con.close();
    }

    public void Begin() {
        while (true) {
            Scanner myObj = new Scanner(System.in);
            System.out.println("Please enter your practitioner id [E] to exit: ");
            String PraID = myObj.nextLine();
            if (PraID.equals("E")) {
                Stop = 1;
                return;
            } else {
                if (this.PractitionerIDs.contains(PraID)) {
                    Stop = 0;
                    this.ThisPracID = PraID;
                    return;
                } else {
                    System.out.println("The practitioner id does not exist");
                    continue;
                }
            }
        }
    }

    public void Load() throws SQLException {
        String tableName = "";
        int sqlCode = 0;      // Variable to hold SQLCODE
        String sqlState = "00000";  // Variable to hold SQLSTATE
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";
        String your_userid = null;
        String your_password = null;
        if (your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        this.con = DriverManager.getConnection(url, your_userid, your_password);
        this.statement = con.createStatement();
        java.sql.ResultSet List_Prac_ID = this.statement.executeQuery("SELECT PRACID FROM MIDWIFES");
        while (List_Prac_ID.next()) {
            String ID = List_Prac_ID.getString("PRACID");
            this.PractitionerIDs.add(ID);
        }
        java.sql.ResultSet List_Test_ID = this.statement.executeQuery("SELECT TESTID\n" +
                "FROM TEST");
        while (List_Test_ID.next()) {
            String ID1 = List_Test_ID.getString("TESTID");
            this.ThisTestID.add(ID1);
        }
        java.sql.ResultSet List_Note_ID = this.statement.executeQuery("SELECT NID\n" +
                "    FROM NOTES");
        while (List_Note_ID.next()) {
            String ID2 = List_Note_ID.getString("NID");
            this.ThisNodeID.add(ID2);
        }
    }
}
