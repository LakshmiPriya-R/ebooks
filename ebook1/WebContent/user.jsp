<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/User</title>
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

<%!
public static File makefile(String name, int pS,int pE,int n)throws IOException
{
	int i;
	
	File pdf= new File(name);
	System.out.println("NAME: "+name);
	
	PDDocument doc= PDDocument.load(pdf);
	PDPage pg = new PDPage();
	PDDocument ContentDoc= new PDDocument();
	for (i=pS;i<=pE;i++)
	{
		//System.out.println("PS: "+Integer.toString(pS));
		pg = (PDPage)doc.getPages().get(i-1);
		ContentDoc.addPage(pg);
	}	
	ContentDoc.save("/Users/yashpal/Desktop/Project/project_data/custom_books/Result"+Integer.toString(n)+".pdf");
	System.out.println("Printing extracted contents.pdf");
	ContentDoc.close();
	File file = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/Result"+Integer.toString(n)+".pdf");
	doc.close();
	return file;
}
%>

<%!
public static void Merge(ArrayList<File>docs) throws IOException
{
	PDFMergerUtility PDFmerger = new PDFMergerUtility();
	PDFmerger.setDestinationFileName("/Users/yashpal/Desktop/Project/project_data/custom_books/Merged.pdf");
	int i;
	for(i=0;i<docs.size();i++)
		PDFmerger.addSource(docs.get(i));
    PDFmerger.mergeDocuments();
    System.out.println("Documents merged");
	
}
%>

<%
String book = request.getParameter("book");
String st = request.getParameter("start");
int start = Integer.parseInt(st);
String en = request.getParameter("end");
int end = Integer.parseInt(en);


File fin = new File("/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/custom_books/test.xml");

DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
Document doc = docBuilder.parse(fin);
Element root = doc.getDocumentElement();



String qry0 = "for $x in doc('/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml')/books/book where $x/title = '"+book+"' return $x/author/text()";
String qry1 = "for $x in doc('/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml')/books/book where $x/title = '"+book+"' return $x/first/text()";
String qry2 = "for $x in doc('/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml')/books/book where $x/title = '"+book+"' return $x/last/text()";
String qry3 = "for $x in doc('/Users/laasya/Desktop/College/sem6/Data Modelling/new/project_data/books.xml')/books/book where $x/title = '"+book+"' return $x/price/text()";

		
XQDataSource ds = new SaxonXQDataSource();
XQConnection conn = ds.getConnection();
XQPreparedExpression exp = conn.prepareExpression(qry0);
XQResultSequence result = exp.executeQuery();


int bookstart = 0, bookend = 0, bookprice = 0;
String auth = "";

while (result.next()) 
{
   
   auth = result.getItemAsString(null);
   
}


exp = conn.prepareExpression(qry1);
result = exp.executeQuery();

while (result.next()) 
{
   String str = result.getItemAsString(null);
   bookend = Integer.parseInt(str);
   
}

exp = conn.prepareExpression(qry2);
result = exp.executeQuery();

while (result.next()) 
{
   String str = result.getItemAsString(null);
   bookend = Integer.parseInt(str);
   
}

exp = conn.prepareExpression(qry3);
result = exp.executeQuery();

while (result.next()) 
{
   String str = result.getItemAsString(null);
   bookprice = Integer.parseInt(str);
   
}


if(start < bookstart || end > bookend)
{
	out.println("<h3>Incorrect page number entries</h3>");
	out.println("<a href = 'user.html'>Re-enter</a>");
}
else
{
	Element newbook = doc.createElement("book");
	root.appendChild(newbook);
	
	int pagecount = end-start+1;
	int cost = pagecount*bookprice;

	Element name = doc.createElement("name");
	Element author = doc.createElement("author");
	Element startpage = doc.createElement("start");
	Element endpage = doc.createElement("end");
	Element bookcost = doc.createElement("cost"); 
			
	name.appendChild(doc.createTextNode(book));
	author.appendChild(doc.createTextNode(auth));
	startpage.appendChild(doc.createTextNode(String.valueOf(start)));
	endpage.appendChild(doc.createTextNode(String.valueOf(end)));
	bookcost.appendChild(doc.createTextNode(String.valueOf(cost)));

	newbook.appendChild(name);
	newbook.appendChild(author);
	newbook.appendChild(startpage);
	newbook.appendChild(endpage);
	newbook.appendChild(bookcost);
	

	TransformerFactory factory = TransformerFactory.newInstance();
	Transformer transformer = factory.newTransformer();
	DOMSource domSource = new DOMSource(doc);
	StreamResult streamResult = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/custom_books/test.xml"));
	transformer.transform(domSource, streamResult);

	DOMSource source = new DOMSource(doc);
	
	out.println("<h3>Successfully selected</h3> <br />");
	out.println("<a href = 'user.html'>Add more pages</a><br />");
	out.println("<a href = 'user1.jsp'>Finish creating custom book</a>");
	
}


%>
<br />


</body>
</html>




