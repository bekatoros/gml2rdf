

<%@page import="org.openrdf.query.resultio.stSPARQLQueryResultFormat"%>
<%@page import="eu.earthobservatory.org.StrabonEndpoint.client.SPARQLEndpoint"%>
<%@page import="org.xml.sax.Locator"%>
<%@page import="org.xml.sax.helpers.DefaultHandler"%>
<%@page import="org.xml.sax.ErrorHandler"%>

<%@page import="java.net.URL"%>
<%@page import="org.openrdf.rio.RDFFormat"%>
<%@page import="java.io.IOException"%>

<%@page import="de.l3s.sesame2.tools.*"%>





<%@page import="javax.xml.bind.Unmarshaller"%>

<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="sun.misc.IOUtils"%>
<%@page import="javax.jms.Session"%>

<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>

<%@page import="javax.xml.transform.TransformerException"%>
<%@page import="javax.xml.transform.ErrorListener"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.transform.Result"%>
<%@page import="javax.xml.validation.Schema"%>
<%@page import="javax.xml.validation.SchemaFactory"%>
<%@page import="javax.xml.validation.Validator"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="javax.xml.transform.stream.StreamSource"%>
<%@page import="javax.xml.transform.Source"%>
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



<div class="container">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">

            <h1 align="center">Transformation Results</h1>
            </br>
            </br>
            <%

                String contentType = request.getContentType();
                if (contentType != null) {

                    MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                    Hashtable myhash = mrequest.getFiles();

                    String property = mrequest.getParameter("property");//"ogr:geometryProperty"; //
                    String namespaces = mrequest.getParameter("namespaces");    //=xmlns:ogr='http://ogr.maptools.org/'"
                    String serverupload = mrequest.getParameter("serverupload");
                    String serverurl = mrequest.getParameter("serverurl");
                    String filetype = mrequest.getParameter("filetype");
                    String kwt = mrequest.getParameter("kwt");
                    String grsstring = mrequest.getParameter("grs");

                    CosUploadFile file = (CosUploadFile) myhash.get("fileToUpload");
                    String strings = new String(file.getData());
                    String datatype=""; //"><strdf:hasGeometry rdf:datatype="http://strdf.di.uoa.gr/ontology#WKT">
                    if (kwt.equals("gml")) {
                    datatype ="\"><strdf:hasGeometry rdf:datatype=\"http://strdf.di.uoa.gr/ontology#GML\" >";
                    }else{
                    datatype ="\"><strdf:hasGeometry rdf:datatype=\"http://strdf.di.uoa.gr/ontology#WKT\" >";
                    }        
                    
                    // myhash.get("fileToUpload")
                    Random myr = new Random();
                    String filename = "" + myr.nextInt(Integer.MAX_VALUE);
                    FileOutputStream outo = new FileOutputStream("../docroot/" + filename + ".gml");
                    outo.write(file.getData());
                    outo.close();

                    
                    Kernow preprocess = new Kernow();
                    preprocess.runSingleFileTransform("../docroot/" + filename + ".gml", "../docroot/preprocess.xsl", "../docroot/" + filename + ".gml");
                       
                    
                    FileInputStream fistream1 = new FileInputStream("../docroot/convert_1.xsl"); // first source file
                    FileInputStream fistream2 = new FileInputStream("../docroot/convert_2.xsl"); //second source file   
                    FileInputStream fistream3 = new FileInputStream("../docroot/convert_3.xsl"); //third source file   
                    FileInputStream fistream4 = new FileInputStream("../docroot/convert_4.xsl"); //third source file   

                    
                    InputStream fistream1_1 = new ByteArrayInputStream(namespaces.getBytes("UTF-8"));
                    InputStream fistream2_1 = new ByteArrayInputStream(property.getBytes("UTF-8"));
                    InputStream fistream2_2 = new ByteArrayInputStream(datatype.getBytes("UTF-8"));
                    InputStream fistream3_1 = new ByteArrayInputStream(property.getBytes("UTF-8"));
                    
                    Vector<InputStream> inputStreams = new Vector<InputStream>();
                    inputStreams.add(fistream1);
                    inputStreams.add(fistream1_1);
                    inputStreams.add(fistream2);
                    inputStreams.add(fistream2_1);
                    inputStreams.add(fistream2_2);
                    inputStreams.add(fistream3);                    
                    inputStreams.add(fistream3_1);
                    inputStreams.add(fistream4);
                    Enumeration<InputStream> enu = inputStreams.elements();
                    SequenceInputStream sistream = new SequenceInputStream(enu);
                    FileOutputStream fostream = new FileOutputStream("../docroot/" + filename + ".xsl"); // destination file   

                    int temp;
                    while ((temp = sistream.read()) != -1) {
                        fostream.write(temp);	// to write to file 

                    }
                    fostream.flush();
                    fostream.close();
                    sistream.close();
                    fistream1.close();

                    fistream1_1.close();
                    fistream2.close();
                    fistream2_1.close();
                    fistream3.close();
                    fistream4.close();
                    
                    String grsdefault="http://www.opengis.net/def/crs/EPSG/0/4326";
                    if ( !grsstring.equals(""))
                    {
                    grsdefault=grsstring;
                      
                    }                    
                    String grs="exclude-result-prefixes='xs' \nversion='2.0'> \n<xsl:output indent='yes'/>\n<xsl:strip-space elements='*'/>"; // Global Reference System
                    if (!kwt.equals("gml")) {
                        FileInputStream fistream5 = new FileInputStream("../docroot/convert_1.xsl"); // first source file
                        InputStream fistream5_1 = new ByteArrayInputStream(namespaces.getBytes("UTF-8"));
                                                
                        FileInputStream fistream6;
                        if (kwt.equals("geosparql")) {    
                        fistream6 = new FileInputStream("../docroot/toWKT_part2_geosparql.xsl");
                        grs+="<xsl:variable name='epsg'  >&lt;"+grsdefault+"&gt; </xsl:variable>";
                         }
                        else{
                       fistream6 = new FileInputStream("../docroot/toWKT_part2_strdf.xsl");
                       grs+="<xsl:variable name='epsg'  >;"+grsdefault+"</xsl:variable>";
                       
                        }
                              
                        InputStream fistream5_2 = new ByteArrayInputStream(grs.getBytes("UTF-8"));
                                         
                       
                        Vector<InputStream> inputStreams2 = new Vector<InputStream>();
                        inputStreams2.add(fistream5);
                        inputStreams2.add(fistream5_1);
                        inputStreams2.add(fistream5_2);
                        inputStreams2.add(fistream6);
                        Enumeration<InputStream> enu2 = inputStreams2.elements();
                        SequenceInputStream sistream2 = new SequenceInputStream(enu2);
                        FileOutputStream fostream2 = new FileOutputStream("../docroot/" + filename + "-1.xsl"); // destination file   

                        int temp2;
                        while ((temp2 = sistream2.read()) != -1) {
                            fostream2.write(temp2);	// to write to file 
                        }
                        fostream2.close();
                        sistream2.close();

                    }

                    File filetodelete;
                    Kernow mytest = new Kernow();
                    String extra="";
                    try {
                     
                        mytest.runSingleFileTransform("../docroot/" + filename + ".gml", "../docroot/" + filename + ".xsl", "../docroot/" + filename + ".rdf");
                        extra = "";
                        if (!kwt.equals("gml")) {
                            extra = "-1";
                        }

                        String rdfto[] = {"../docroot/" + filename + extra + ".rdf", "." + filetype};

                        if (!kwt.equals("gml")) {

                            mytest.runSingleFileTransform("../docroot/" + filename + ".rdf", "../docroot/" + filename + "-1.xsl", "../docroot/" + filename + "-1.rdf");
                        }

                        if (!filetype.equals("rdf")) {
                            RDF2RDF.main(rdfto);// myconverter;// = new RDF2RDF(rdfto); 
                        }
                        if (!kwt.equals("gml")) {
               /**/ filetodelete = new File("../docroot/" + filename + ".rdf");
                    if (filetodelete.exists()) {
                          filetodelete.delete();
                    }
       
   }
                        //myconverter();
                        out.print("<p>The file has been successfully converted</p>"
                                + "<a href='download.jsp?file=" + filename +extra+ "&ftype=" + filetype + "' target='_blank' >Download RDF file</a>"
                                + "</br><a href='index.jsp ' > Convert new GML </a></br>");

                        /**/ if (serverupload != null) {
                            SPARQLEndpoint endpoint;
                            String[] testQueries;
                            stSPARQLQueryResultFormat format;
                            boolean res1 = false;
                            // initialize endpoint	

                            try {
                                endpoint = new SPARQLEndpoint(serverurl, 8080, "strabon-endpoint-3.2.9/query.jsp");
   
                                res1 = endpoint.store("../docroot/" + filename + ".rdf", RDFFormat.RDFXML, new URL("file://" + filename));
                                //     endpoint.store(data, format, namedGraph);

                                if (res1) {
                                    out.print("<p>The file has been successfully uploaded to " + serverurl + "</p>");
                                } else {
                                    out.print("<p>The file could not be uploaded to server " + serverurl + ":8080 </p>");
                                }
                            } catch (Exception ex) {
                                out.println("<p>The server " + serverurl + " is not accessible</p>"+ex.toString());
                            }

                        }
                        /**/
                    } catch (Exception ex) {

                        out.print("<p>Some Prefix is not Set, or file not GML</p>"
                                + "    <a href='index.jsp'>Add the missing Prefixes and re-upload you GML file  </a>" + ex.toString());
                    }

   if (!kwt.equals("gml")) {

                     
                    /**/ filetodelete = new File("../docroot/" + filename + "-1.xsl");
                    if (filetodelete.exists()) {
                        filetodelete.delete();
                    }
   }
                    /**/ filetodelete = new File("../docroot/" + filename + ".xsl");
                    if (filetodelete.exists()) {
                        filetodelete.delete();
                    }

                    filetodelete = new File("../docroot/" + filename + ".gml");
                    if (filetodelete.exists()) {
                        filetodelete.delete();
                    }

                }


            %>


        </div>
        <div class="col-md-2"></div>
    </div>

    <%@include file="footer.jsp" %>