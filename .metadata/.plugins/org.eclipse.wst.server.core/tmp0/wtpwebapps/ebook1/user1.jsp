<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JKL/GetBook</title>
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
<%@ page import = "javax.xml.transform.sax.*" %>
<%@ page import = "javax.xml.transform.sax.*" %>
<%@ page import = "java.nio.file.Files"  %>
<%@ page import = "org.apache.xmlgraphics.io.ResourceResolver" %>
<%@ page import = "org.w3c.dom.*" %>

<%@ page import = "org.apache.pdfbox.pdmodel.PDPage" %>
<%@ page import = "org.apache.pdfbox.pdmodel.PDDocument" %>

<%@ page import = "net.sf.saxon.xqj.SaxonXQDataSource" %>

<%@ page import = "javax.xml.transform.TransformerFactory" %>
<%@ page import = "javax.xml.transform.sax.SAXResult" %>
<%@ page import = "javax.xml.transform.stream.StreamSource" %>

<%@ page import = "javax.xml.transform.stream.StreamSource" %>

<%@ page import = "org.apache.fop.apps.*" %>
<%@ page import = "org.apache.xmlgraphics.util.MimeConstants" %>
<%@ page import = "org.apache.avalon.framework.configuration.DefaultConfigurationBuilder" %>



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

//String qry1 = "for $x in doc('books.xml')/books/book where $x/title = '"+book+"' return $x/first/text()";
//String qry2 = "for $x in doc('books.xml')/books/book where $x/title = '"+book+"' return $x/last/text()";


File inputFile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/test.xml");
DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
Document doc = dBuilder.parse(inputFile);
Element root = doc.getDocumentElement();		

NodeList nList = doc.getElementsByTagName("book");

XQDataSource ds = new SaxonXQDataSource();
XQConnection conn = ds.getConnection();
//XQPreparedExpression exp = conn.prepareExpression(qry1);
//XQResultSequence result = exp.executeQuery();

ArrayList<File> arrFile = new ArrayList<File>();

int totalcost = 0;

for(int i =0;i<nList.getLength();i++)
{
	Node n = nList.item(i);
	Element e = (Element) n;
	String name = e.getElementsByTagName("name").item(0).getTextContent();
	String path = "/Users/yashpal/Desktop/Project/project_data/pub_books/"+name+".pdf";
	int start = Integer.parseInt(e.getElementsByTagName("start").item(0).getTextContent());
	int end = Integer.parseInt(e.getElementsByTagName("end").item(0).getTextContent());
	totalcost += Integer.parseInt(e.getElementsByTagName("cost").item(0).getTextContent());
	File file = makefile(path,start,end,i);
	arrFile.add(file);
}

Element totcost = doc.createElement("total");
totcost.appendChild(doc.createTextNode(String.valueOf(totalcost)));

root.appendChild(totcost);

TransformerFactory factory = TransformerFactory.newInstance();
Transformer transformer = factory.newTransformer();
DOMSource domSource = new DOMSource(doc);
StreamResult streamResult = new StreamResult(new File("/Users/yashpal/Desktop/Project/project_data/custom_books/test.xml"));
transformer.transform(domSource, streamResult);

DOMSource source = new DOMSource(doc);

String qry1 = "for $x in doc('/Users/yashpal/Desktop/Project/project_data/custom_books/test.xml')/books return $x/customtitle/text()";
//String qry2 = "for $x in doc('/home/kedar/iiitb/sem6/dm/project_data/custom_books/test.xml')/books return $x/price/text()";

XQPreparedExpression exp = conn.prepareExpression(qry1);
XQResultSequence result = exp.executeQuery();

String customtitle="",customname="";
String intername = "/Users/yashpal/Desktop/Project/project_data/custom_books/temp.pdf";
while (result.next()) 
{
	customname = result.getItemAsString(null);
	System.out.println(customname);

   	customtitle = "/Users/yashpal/Desktop/Project/project_data/custom_books/"+customname+".pdf";
}
System.out.println(customtitle);

File newfile = new File(customtitle);
File interfile = new File(intername);
if(nList.getLength() > 1)
{
	Merge(arrFile);
	//File newfile = new File(customtitle);
	File oldfile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/Merged.pdf");
	oldfile.renameTo(interfile);
	for(int i=0;i<nList.getLength();i++)
	{
		File deletefile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/Result"+Integer.toString(i)+".pdf");;
		deletefile.delete();
	}
}
else
{
	//File newfile = new File(customtitle);
	File oldfile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/Result0.pdf");
	oldfile.renameTo(interfile);
}
File newxml = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/"+customname+".xml");
inputFile.renameTo(newxml);

File xmlfile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/"+customname+".xml");
File xsltfile = new File("/Users/yashpal/Desktop/Project/project_data/books.xsl");
File pdffile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/ResultPDF.pdf");

FopFactory fopFactory = FopFactory.newInstance(new File("/Users/yashpal/Desktop/Project/project_data/fop.xconf"));
System.out.println("1");
FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

OutputStream outstr = new java.io.FileOutputStream(pdffile);
outstr = new java.io.BufferedOutputStream(outstr);

Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, outstr);
TransformerFactory factory1 = TransformerFactory.newInstance();
Transformer transformer1 = factory1.newTransformer(new StreamSource(xsltfile));
transformer1.setParameter("versionParam", "2.0");
Source src = new StreamSource(xmlfile);
System.out.println("1");
Result res = new SAXResult(fop.getDefaultHandler());
// Start XSLT transformation and FOP processing
transformer1.transform(src, res);

System.out.println("1");
ArrayList<File> finalfiles = new ArrayList<File>();

finalfiles.add(pdffile);
finalfiles.add(interfile);

outstr.close();


Merge(finalfiles);

File oldfile = new File("/Users/yashpal/Desktop/Project/project_data/custom_books/Merged.pdf");
//Files.move(newfile.toPath(),oldfile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
oldfile.renameTo(newfile);
	



out.println("<h3>Cost of book: "+totalcost+"</h4>");

out.println("<a href = 'userstart.html'>Create another book</a><br />");
out.println("<a href = 'userview.jsp'>View book</a><br />");
out.println("<a href = 'userhome.html'>Home page</a><br />");



%>



<br />


</body>
</html>




