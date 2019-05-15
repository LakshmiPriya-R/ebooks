<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/User_View</title>
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

File fin1 = new File("/Users/yashpal/Desktop/Project/project_data/users.xml");

DocumentBuilderFactory docFactory1 = DocumentBuilderFactory.newInstance();
DocumentBuilder docBuilder1 = docFactory1.newDocumentBuilder();
Document doc1 = docBuilder1.parse(fin1);
Element root = doc1.getDocumentElement();

NodeList user = doc1.getElementsByTagName("current");
Element thisuser = (Element)user.item(0);

String curuser = thisuser.getTextContent();
int flag =1;

XQDataSource ds = new SaxonXQDataSource();
XQConnection conn = ds.getConnection();
String qry = "for $x in doc('/Users/yashpal/Desktop/Project/project_data/users.xml')/users/user where $x/username = '"+curuser+"' return $x/book/text()";

XQPreparedExpression exp = conn.prepareExpression(qry);
XQResultSequence result = exp.executeQuery();

if(!result.next())
{
	flag=0;
}

if(flag == 1)
{
	exp = conn.prepareExpression(qry);
	result = exp.executeQuery();


	String str="";
	out.println("<form action = 'showbook.jsp'>");
	out.println("<select name = 'booklist'>");
	while (result.next()) 
	{
	   str = result.getItemAsString(null);
	   out.println("<option value = '"+str+"'>"+str+"</option>");
	}
	out.println("<input type = 'submit' />");

	out.println("</select>");
	out.println("</form>");
	
}
else
{
	out.println("<h4>No custom books made</h4>");
	out.println("<a href = 'userhome.html'>Back</a>");
}
%>


</body>
</html>