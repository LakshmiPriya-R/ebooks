<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/Publish</title>
<link rel = "stylesheet" type = "text/css" href = "start_style.css" />
</head>
<body>

<%@ page import = "java.io.*" %>
<%@ page import = "javax.xml.xquery.*" %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "javax.xml.transform.*" %>
<%@ page import = "javax.xml.transform.dom.*" %>
<%@ page import = "javax.xml.transform.stream.*" %>
<%@ page import = "org.w3c.dom.*" %>


<%
String book = request.getParameter("book");
String auth = request.getParameter("author");
String pr = request.getParameter("price");
String st = request.getParameter("start");
String en = request.getParameter("end");

int start = Integer.parseInt(st);
int end = Integer.parseInt(en);
int pric = Integer.parseInt(pr);


File fin = new File("/Users/yashpal/Desktop/Project/project_data/books.xml");
DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
Document doc = docBuilder.parse(fin);
Element root = doc.getDocumentElement();

Element newbook = doc.createElement("book");
root.appendChild(newbook);

Element price = doc.createElement("price");
Element title = doc.createElement("title");
Element author = doc.createElement("author");
Element first = doc.createElement("first");
Element last = doc.createElement("last");

//Element price = doc.createElement("price");
//name.appendChild(doc.createTextNode(book));;

title.appendChild(doc.createTextNode(book));
author.appendChild(doc.createTextNode(auth));
first.appendChild(doc.createTextNode(String.valueOf(start)));
last.appendChild(doc.createTextNode(String.valueOf(end)));
//year.appendChild(doc.createTextNode("2008"));
price.appendChild(doc.createTextNode(String.valueOf(pric)));

newbook.appendChild(title);
newbook.appendChild(author);
newbook.appendChild(first);
newbook.appendChild(last);
//newbook.appendChild(year);
newbook.appendChild(price);

TransformerFactory factory = TransformerFactory.newInstance();
Transformer transformer = factory.newTransformer();
DOMSource domSource = new DOMSource(doc);
StreamResult streamResult = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/books.xml"));
transformer.transform(domSource, streamResult);

DOMSource source = new DOMSource(doc);

%>
<br />
<h3>Paste your book PDF in the following folder: </h3>
<h4>/Users/yashpal/Desktop/Project/project_data/pub_books</h4>

<a href = "publish.html">Publish another book</a>
<br />
<a href = "start.html">Back</a>

</body>
</html>