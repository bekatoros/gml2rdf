<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%    

  String name=request.getParameter( "file" );
  String ftype=request.getParameter( "ftype" );
  String filename = name+"."+ftype;   
  String filepath = "../docroot";   
  response.setContentType("APPLICATION/octet-stream");   
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
  InputStream in =null;
  ServletOutputStream outs =response.getOutputStream();
         
  try{
  in = new BufferedInputStream(new FileInputStream(filepath+"/"+filename));
  int ch;
  while((ch=in.read())!=-1)
  {
  outs.print((char) ch);
  }
  
  }
  
  catch(Exception ex){}
 
   File filetodelete = new File(filepath+"/"+filename);
       if(filetodelete.exists()) { 
        filetodelete.delete();
        }
     File filetodelete2 = new File(filepath+"/"+name+".rdf");
       if(filetodelete2.exists()) { 
        filetodelete2.delete();
        }   
       
%> 