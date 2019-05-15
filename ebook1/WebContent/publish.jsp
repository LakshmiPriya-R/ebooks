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
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>


<%
String book = request.getParameter("book");
String auth = request.getParameter("author");
String pr = request.getParameter("price");
String st = request.getParameter("start");
String en = request.getParameter("end");
String up = request.getParameter("upload");

File file ;
int maxFileSize = 5000 * 1024;
int maxMemSize = 5000 * 1024;
String filePath = "Users/Laasya/Desktop/College/sem 6/Data modelling";

String contentType = request.getContentType();
if ((contentType.indexOf("multipart/form-data") >= 0)) {

   DiskFileItemFactory factory = new DiskFileItemFactory();
   
   factory.setSizeThreshold(maxMemSize);
   factory.setRepository(new File("Users/Laasya/Desktop/College/sem 6/Data modelling/PDF"));
   
   ServletFileUpload upload = new ServletFileUpload(factory);
   upload.setSizeMax( maxFileSize );
   
   try{ 
      List fileItems = upload.parseRequest(request);
      Iterator i = fileItems.iterator();
      out.println("<html>");
      out.println("<body>");
      while ( i.hasNext () ) 
      {
         FileItem fi = (FileItem)i.next();
         if ( !fi.isFormField () )  {
             String fieldName = fi.getFieldName();
             String fileName = fi.getName();
             boolean isInMemory = fi.isInMemory();
             long sizeInBytes = fi.getSize();
             file = new File( filePath + "yourFileName") ;
             fi.write( file ) ;
             out.println("Uploaded Filename: " + filePath + fileName + "<br>");
         }
      }
      out.println("</body>");
      out.println("</html>");
   }catch(Exception ex) {
      System.out.println(ex);
   }
}else{
   out.println("<html>");
   out.println("<body>");
   out.println("<p>No file uploaded</p>"); 
   out.println("</body>");
   out.println("</html>");
}
int start = Integer.parseInt(st);
int end = Integer.parseInt(en);
int pric = Integer.parseInt(pr);


File fin = new File("/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml");
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
Element upload = doc.createElement("upload");

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
StreamResult streamResult = new StreamResult(new File("/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml"));
transformer.transform(domSource, streamResult);

DOMSource source = new DOMSource(doc);

%>
<br />
<h3>Paste your book PDF in the following folder: </h3>
<h4>//Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/pub_books</h4>

<a href = "publish.html">Publish another book</a>
<br />
<a href = "start.html">Back</a>

</body>
</html>