  <%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Vector"%>
<%@page import="java.io.SequenceInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="net.sf.kernow.Kernow"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.parsing.CosUploadFile"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="javazoom.upload.*"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.sql.*" %>

<%@include file="header.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="jumbotron">
      <div class="container">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
      </div>
    </div>

    <div class="container">

<%



    try {

        String contentType = request.getContentType();
        if (contentType != null) {


            MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
            Hashtable myhash = mrequest.getFiles();

            String property = mrequest.getParameter("property");//"ogr:geometryProperty"; //
            String namespaces = mrequest.getParameter("namespaces");    //=xmlns:ogr='http://ogr.maptools.org/'"


            CosUploadFile file = (CosUploadFile) myhash.get("fileToUpload");
            String strings = new String(file.getData());

            Random myr = new Random();
            String filename = "" + myr.nextInt(Integer.MAX_VALUE);
            FileOutputStream outo = new FileOutputStream(filename + ".gml");
            outo.write(file.getData());
            outo.close();



            FileInputStream fistream1 = new FileInputStream("docroot/convert_1.xsl"); // first source file
            FileInputStream fistream2 = new FileInputStream("docroot/convert_2.xsl"); //second source file   
            FileInputStream fistream3 = new FileInputStream("docroot/convert_3.xsl"); //third source file   
            InputStream fistream1_1 = new ByteArrayInputStream(namespaces.getBytes("UTF-8"));
            InputStream fistream2_1 = new ByteArrayInputStream(property.getBytes("UTF-8"));


            Vector<InputStream> inputStreams = new Vector<InputStream>();
            inputStreams.add(fistream1);
            inputStreams.add(fistream1_1);
            inputStreams.add(fistream2);
            inputStreams.add(fistream2_1);
            inputStreams.add(fistream3);
            Enumeration<InputStream> enu = inputStreams.elements();
            SequenceInputStream sistream = new SequenceInputStream(enu);
            FileOutputStream fostream = new FileOutputStream("docroot/" + filename + ".xsl"); // destination file   
            int temp;
            while ((temp = sistream.read()) != -1) {
                    fostream.write(temp);	// to write to file 
            }
            fostream.close();
            sistream.close();




            Kernow mytest = new Kernow();

            mytest.runSingleFileTransform(filename + ".gml", "docroot/" + filename + ".xsl", "docroot/" + filename + ".rdf");

            File filetodelete = new File(filename + ".gml");
            if (filetodelete.exists()) {
                filetodelete.delete();
            }
            out.print("<p>doulepse</p>"
                    + "<a href='download.jsp?file=" + filename + "' target='_blank' >download</a>");

            filetodelete = new File("docroot/" + filename + ".xsl");
            if (filetodelete.exists()) {
                filetodelete.delete();
            }

            /*http://openrdf.callimachus.net/sesame/2.7/docs/users.docbook?view#section-repository-api
             * Repository repo = new SailRepository(     new ForwardChainingRDFSInferencer(      new MemoryStore()));
             repo.initialize();
             Repository nativeRep = new SailRepository(new NativeStore());
             nativeRep.initialize();
 
             String fileName = "/path/to/example.rdf";
             File dataFile = new File(fileName);
             RepositoryConnection conn = nativeRep.getConnection();
             try {
             conn.add(dataFile, "file://" + fileName, RDFFormat.forFileName(fileName));
             }
             finally {
             conn.close();
             }
             */
        }




    } catch (Exception ex) {
        System.out.println(ex.toString());
        out.println(ex.toString());
        // TODO handle custom exceptions here
    }



%>




<%@include file="footer.jsp" %>