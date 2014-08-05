<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%    

  String name=request.getParameter( "file" );
  String filename = name+".rdf";   
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
  /*
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath+"/"+filename);  
     response.setContentLength(fileInputStream.available());
  byte b[]= new byte[fileInputStream.available()];
    //        fileInputStream.read(b)
            
      OutputStream os = response.getOutputStream();
      os.write(b);
      os.close();
      
      response.flushBuffer();
            /*int i;   
  
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close();   
  */
   File filetodelete = new File(filepath+"/"+filename);
       if(filetodelete.exists()) { 
        filetodelete.delete();
        }
%> 