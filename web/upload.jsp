
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

                    CosUploadFile file = (CosUploadFile) myhash.get("fileToUpload");
                    String strings = new String(file.getData());
                    // myhash.get("fileToUpload")
                    Random myr = new Random();
                    String filename = "" + myr.nextInt(Integer.MAX_VALUE);
                    FileOutputStream outo = new FileOutputStream("../docroot/" + filename + ".gml");
                    outo.write(file.getData());
                    outo.close();

                    /* */ FileInputStream fistream1 = new FileInputStream("../docroot/convert_1.xsl"); // first source file
                    FileInputStream fistream2 = new FileInputStream("../docroot/convert_2.xsl"); //second source file   
                    FileInputStream fistream3 = new FileInputStream("../docroot/convert_3.xsl"); //third source file   

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
                    FileOutputStream fostream = new FileOutputStream("../docroot/" + filename + ".xsl"); // destination file   

                    int temp;
                    while ((temp = sistream.read()) != -1) {
                        fostream.write(temp);	// to write to file 
                    }
                    fostream.close();
                    sistream.close();

                    File filetodelete;
                    Kernow mytest = new Kernow();
                 //   Source mysource = new StreamSource(new File("../docroot/" + filename + ".xsl"));//=new Source();

                    try {
                     //   TransformerFactory transFactory = TransformerFactory.newInstance();
                      //  Transformer transformer;
                      //  transformer = transFactory.newTransformer(mysource);

                        mytest.runSingleFileTransform("../docroot/" + filename + ".gml", "../docroot/" + filename + ".xsl", "../docroot/" + filename + ".rdf");

                        String rdfto[]= {"../docroot/"+filename+".rdf",".nt"};
                        RDF2RDF.main(rdfto);// myconverter;// = new RDF2RDF(rdfto); 
                        //myconverter();
                        
                        out.print("<p>The file has been successfully converted</p>"
                                + "<a href='download.jsp?file=" + filename +"&ftype=rdf"+ "' target='_blank' >Download RDF file</a>"
                                + "</br><a href='index.jsp ' > Convert new GML </a></br>");

                       
  /*                      if (serverupload != null) {
                            SPARQLEndpoint endpoint;
                            String[] testQueries;
                            stSPARQLQueryResultFormat format;
                            boolean res1 = false;
                        // initialize endpoint	

                            try {
                        //        endpoint = new SPARQLEndpoint(serverurl, 8080, "strabon-endpoint/Query");

                          //      res1 = endpoint.store("../docroot/" + filename + ".rdf", RDFFormat.RDFXML, new URL("file://" + filename));
                     //   endpoint.store(data, format, namedGraph)

                                if (res1) {
                                    out.print("<p>The file has been successfully uploaded to " + serverurl + "</p>");
                                } else {
                                    out.print("<p>The file could not be uploaded to server " + serverurl + ":8080 </p>");
                                }
                            } catch (Exception ex) {
                                out.println("<p>The server "+serverurl+" is not accessible</p>");
                            }

                            
                        }
*/
                    } catch (Exception ex) {

                        out.print("<p>Some Prefix is not Set, or file not GML</p>"
                                + "    <a href='index.jsp'>Add the missing Prefixes and re-upload you GML file  </a>"+ex.toString());
                    }


                    /**/  filetodelete = new File("../docroot/" + filename + ".xsl");
                    if (filetodelete.exists()) {
                        filetodelete.delete();
                    }

                    filetodelete = new File("../docroot/" + filename + ".gml");
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
                     */   // "../docroot/" + filename + ".rdf"
                    //    String wktStr = "";

           //Charset charst = new Charset("utf-8");
                        // List<String> lines = Files.readAllLines(Paths.get("../docroot/" + filename + ".rdf"), StandardCharsets.UTF_8);
                        //FileReader  fr = new FileReader("../docroot/" + filename + ".rdf");
        //String fname= "../docroot/" + filename + ".rdf";
                      //  File striny = new File("../docroot/" + filename + ".gml");
          // FileReader fr = new FileReader(fname);
                        // out.print(fr.toString());
                        //File fr= new File("../docroot/" + filename + ".rdf");
           
                        // out.print(striny);
                      /*   try{	
                        PrecisionModel precisionModel = new PrecisionModel(1000);
                         GeometryFactory geometryFactory = new GeometryFactory(precisionModel);
                         GMLHandler gr = new GMLHandler(geometryFactory,new DefaultHandler());
GMLReader gmlr = new GMLReader();                        
//gmlr.
// gmlReader.load(new DriverProperties()) ; 
                         //gr.setDocumentLocator(new Locator());
                       //  gr.
                         Geometry g = gr.getGeometry();
                         WKTWriter writer = new WKTWriter();
       
                         if (null != g) {
                         wktStr = writer.write(g);
                         
                          
                         System.out.println(wktStr);

                         }
                         }catch(Exception ex1)
                         {
                         out.print(ex1.toString());
                         }
                        */
                        /*     try{
                    

                         JAXBContext context = JAXBContext.newInstance("org.jvnet.ogc.gml.v_3_1_1.jts");
             
                         WKTWriter wktWriter = new WKTWriter();
 
                         Unmarshaller unmarshaller = context.createUnmarshaller();
                         unmarshaller.setProperty(name, value);
                         Geometry geometry = (Geometry) unmarshaller.unmarshal(striny);
 
                         System.out.println(wktWriter.write(geometry));
        
                         }catch(Exception ex1)
                         {
                         out.print(ex1.toString());
                         }
                         */
                     
                }


            %>


        </div>
        <div class="col-md-2"></div>
    </div>

    <%@include file="footer.jsp" %>