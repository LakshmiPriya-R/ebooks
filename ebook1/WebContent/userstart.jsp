<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/Book</title>
<link rel = "stylesheet" type = "text/css" href = "start_style.css" />
</head>
<body>

<%@ page import = "java.io.*" %>
<%@ page import = "javax.xml.xquery.*" %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "javax.xml.transform.*" %>
<%@ page import = "javax.xml.transform.dom.*" %>
<%@ page import = "javax.xml.transform.stream.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "org.apache.pdfbox.multipdf.PDFMergerUtility" %>
<%@ page import = "org.w3c.dom.*" %>
<%@ page import = "org.apache.pdfbox.pdmodel.PDPage" %>
<%@ page import = "org.apache.pdfbox.pdmodel.PDDocument" %>

<%@ page import = "net.sf.saxon.xqj.SaxonXQDataSource" %>

<%

String customname = request.getParameter("custom");

DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
Document doc = dBuilder.newDocument();

Element rootElement = doc.createElement("books");
doc.appendChild(rootElement);

Element customtitle = doc.createElement("customtitle");
customtitle.appendChild(doc.createTextNode(customname));
rootElement.appendChild(customtitle);

TransformerFactory transformerFactory = TransformerFactory.newInstance();
Transformer transformer = transformerFactory.newTransformer();
DOMSource domsource = new DOMSource(doc);
StreamResult streamresult = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/custom_books/test.xml"));
transformer.transform(domsource, streamresult); 

DOMSource source = new DOMSource(doc);





File fin1 = new File("/Users/yashpal/Desktop/Project/project_data/users.xml");
//gets the books that the user is allowed to access
DocumentBuilderFactory docFactory1 = DocumentBuilderFactory.newInstance();
DocumentBuilder docBuilder1 = docFactory1.newDocumentBuilder();
Document doc1 = docBuilder1.parse(fin1);
Element root = doc1.getDocumentElement();

NodeList user = doc1.getElementsByTagName("current");
Element thisuser = (Element)user.item(0);
String curuser = thisuser.getTextContent();

System.out.println(curuser);

NodeList nList = doc1.getElementsByTagName("user");
System.out.println(nList.item(0).getLocalName());

Element newbook = doc1.createElement("book");
newbook.appendChild(doc1.createTextNode(customname));

for(int i=0;i<nList.getLength();i++)
{
	//if(nList.item(i).getTextContent().equals(curuser))
	Element e = (Element)nList.item(i);
	//System.out.println(e.getLocalName());
	NodeList nl = e.getChildNodes();
	for(int j=0;j<nl.getLength();j++)
	{
		if(nl.item(j).getTextContent().equals(curuser))
		{
			e.appendChild(newbook);
		}
			
	}
	//Element us = e.getChild("name");
}

TransformerFactory factory1 = TransformerFactory.newInstance();
Transformer transformer1 = factory1.newTransformer();
DOMSource domSource1 = new DOMSource(doc1);
StreamResult streamResult1 = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/users.xml"));
transformer1.transform(domSource1, streamResult1);

DOMSource source1 = new DOMSource(doc1);


String qry0 = "for $x in doc('/Users/yashpal/Desktop/Project/project_data/books.xml')/books/book return $x/title/text()";

XQDataSource ds = new SaxonXQDataSource();
XQConnection conn = ds.getConnection();
XQPreparedExpression exp = conn.prepareExpression(qry0);
XQResultSequence result = exp.executeQuery();

out.println("<form action = 'user.jsp'>");
out.println("<label> Select book to extract pages from: </label>");
out.println("<select name = 'book'>");

while (result.next()) 
{
   String str = result.getItemAsString(null);
   out.println("<option value = '"+str+"'>"+str+"</option>");
}
out.println("</select>");
out.println("<br /><label> Enter start page: </label><input type = 'text' name = 'start' /><br /><label> Enter end page: </label><input type = 'text' name = 'end' /><br /><input type = 'submit' /></form>");



%>

</body>
</html>