import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SearchBook extends HttpServlet {
public void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException,IOException{
response.setContentType("text/html"); 
HttpSession session = request.getSession(true);
List booklist=new ArrayList();
Connection con = null;

String url = "jdbc:mysql://localhost:3306/";
String db = "searchbook";
String driver = "com.mysql.jdbc.Driver";
String user = "root";
String pass = "";


BookName =request.getParameter("book name");
BookAuthor =request.getParameter("book author");
String sqlquery="SELECT * FROM book WHERE book_name LIKE '%%' ";
if(BookName!=null && !(Book Name.equals(""))){
sqlquery+=" and Book_name='"+Book Name+"'";
}
if(BookAuthor!=null && !(BookAuthor.equals("-1"))){
sqlquery+=" and Book_Author='"+BookAuthor+"'";
}

try{
Class.forName(driver);
con = DriverManager.getConnection(url+db, user, pass);
try{
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(sqlquery);
while (rs.next()) {
List book=new ArrayList();
book.add(rs.getString(1));
book.add(rs.getString(2));
book.add(rs.getString(3));
book.add(rs.getString(4));
booklist.add(book);
}
}catch (SQLException s){
System.out.println("SQL statement is not executed!");
}
}
catch (Exception e){
e.printStackTrace();
}
request.setAttribute("booklist",booklist); 
RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/usersearch.jsp");
dispatcher.forward(request, response); 
}

}