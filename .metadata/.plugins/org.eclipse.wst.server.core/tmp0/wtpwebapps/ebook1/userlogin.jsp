<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/Login</title>
<link rel = "stylesheet" type = "text/css" href = "start_style.css" />
</head>
<body>
<%@ page import = "org.apache.pdfbox.multipdf.PDFMergerUtility" %>

<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.xml.xquery.*" %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "javax.xml.transform.*" %>
<%@ page import = "javax.xml.transform.dom.*" %>
<%@ page import = "javax.xml.transform.stream.*" %>
<%@ page import = "org.w3c.dom.*" %>

<%@ page import = "org.apache.pdfbox.pdmodel.PDPage" %>
<%@ page import = "org.apache.pdfbox.pdmodel.PDDocument" %>

<%@ page import = "net.sf.saxon.xqj.SaxonXQDataSource" %>

<%
String username = request.getParameter("uname");
String password = request.getParameter("pass");

XQDataSource ds = new SaxonXQDataSource();
XQConnection conn = ds.getConnection();

String qry = "for $x in doc('/Users/yashpal/Desktop/Project/project_data/users.xml')/users/user where $x/username = '"+username+"' return $x/password/text()";

XQPreparedExpression exp = conn.prepareExpression(qry);
XQResultSequence result = exp.executeQuery();

String str = "";
while (result.next()) 
{
   str = result.getItemAsString(null);  
}

if(str.equals(""))
{
	out.println("<h4>Invalid username</h4><br />");
	out.println("<a href = 'userlogin.html'>Login again</a><br />");
}
else if(!str.equals(password))
{
	out.println("<h4>Invalid password</h4><br />");
	out.println("<a href = 'userlogin.html'>Login again</a><br />");
}
else
{
	File fin = new File("/Users/yashpal/Desktop/Project/project_data/users.xml");

	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	Document doc = docBuilder.parse(fin);
	Element root = doc.getDocumentElement();
	NodeList nl = root.getElementsByTagName("current");
	Node n = nl.item(0);
	Element cur = (Element)nl.item(0);
	n.setTextContent(username);


	TransformerFactory factory = TransformerFactory.newInstance();
	Transformer transformer = factory.newTransformer();
	DOMSource domSource = new DOMSource(doc);
	StreamResult streamResult = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/users.xml"));
	transformer.transform(domSource, streamResult);

	DOMSource source = new DOMSource(doc);
	
	out.println("<a href = 'userstart.html'>Create new book</a><br />");
	out.println("<a href = 'userview.jsp'>View custom books</a><br />");
	out.println("<a href = 'logout.jsp'>Log out</a>");
}
%>
</body>
</html>