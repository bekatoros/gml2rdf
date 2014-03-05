<%@page import="java.io.File"%>
<%    

  String name=request.getParameter( "file" );
  String filename = name+".rdf";   
  String filepath = "docroot";   
  response.setContentType("APPLICATION/OCTET-STREAM");   
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath+"/"+filename);  
            
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close();   
  
   File filetodelete = new File(filepath+"/"+filename);
       if(filetodelete.exists()) { 
        filetodelete.delete();
        }
%> 