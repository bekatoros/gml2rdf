  
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


    <form role="form" id='upload' action='upload.jsp' method='post' class="form-horizontal" enctype='multipart/form-data' >                                      

        <div class="form-group">
            <label class="form-label"  for='property'>Geo Property</label> 
          <INPUT  type="text" id="property" class="form-control" name='property'   />
        </div>
        <div class="form-group">
            <label class="form-label"  for='namespaces'>Namespaces</label> 
  
            <textarea type="text" class="form-control" id="namespaces" name='namespaces'   >
            </textarea>
        </div>
        <div class="form-group">
            <label class="form-label"  for='fileToUpload'>Επιλογή αρχείου:</label> 
      <INPUT type='file' name='fileToUpload'  class="input-file"  id='fileToUpload' onchange='fileSelected();' />  
      
        </div>

        <div class="form-group">
            
                 <button type="submit" id='bt1' class="btn btn-default">Υποβολή</button>
          
        </div>
           </br>
    <div id='prbar'></div>
    <div id='fileSize'></div>
        
    </form>

    <%@include file="footer.jsp" %>