/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.7
 * Generated at: 2018-04-24 09:46:19 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import java.util.*;
import java.io.*;
import javax.xml.xquery.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.sax.*;
import javax.xml.transform.sax.*;
import java.nio.file.Files;
import org.apache.xmlgraphics.io.ResourceResolver;
import org.w3c.dom.*;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDDocument;
import net.sf.saxon.xqj.SaxonXQDataSource;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamSource;
import org.apache.fop.apps.*;
import org.apache.xmlgraphics.util.MimeConstants;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;

public final class user1_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {


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

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("org.w3c.dom");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.xml.transform.sax");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_packages.add("javax.xml.parsers");
    _jspx_imports_packages.add("javax.xml.transform.dom");
    _jspx_imports_packages.add("javax.xml.transform");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.io");
    _jspx_imports_packages.add("javax.xml.xquery");
    _jspx_imports_packages.add("javax.xml.transform.stream");
    _jspx_imports_packages.add("org.apache.fop.apps");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("net.sf.saxon.xqj.SaxonXQDataSource");
    _jspx_imports_classes.add("java.nio.file.Files");
    _jspx_imports_classes.add("org.apache.xmlgraphics.util.MimeConstants");
    _jspx_imports_classes.add("org.apache.pdfbox.pdmodel.PDDocument");
    _jspx_imports_classes.add("javax.xml.transform.stream.StreamSource");
    _jspx_imports_classes.add("org.apache.avalon.framework.configuration.DefaultConfigurationBuilder");
    _jspx_imports_classes.add("org.apache.pdfbox.pdmodel.PDPage");
    _jspx_imports_classes.add("javax.xml.transform.TransformerFactory");
    _jspx_imports_classes.add("javax.xml.transform.sax.SAXResult");
    _jspx_imports_classes.add("org.apache.xmlgraphics.io.ResourceResolver");
    _jspx_imports_classes.add("org.apache.pdfbox.multipdf.PDFMergerUtility");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("<title>JKL/GetBook</title>\n");
      out.write("<link rel = \"stylesheet\" type = \"text/css\" href = \"start_style.css\" />\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');


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




      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<br />\n");
      out.write("\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
