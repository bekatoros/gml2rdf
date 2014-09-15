  
<%@include file="header.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--
<div class="jumbotron">
    <div class="container">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>
</div>
-->
<div class="container">
</br>
<h1 align="center">Online GML to stRDF converter</h1>
    <form role="form" id='upload' action='upload.jsp' method='post' class="form-horizontal" enctype='multipart/form-data' >                                      

        <div class="form-group">
            <label class="col-sm-2 control-label" for='property'>Geo Property</label> 
             <div class="col-sm-10">
                 <INPUT  type="text" id="property" class="form-control" name='property'  placeholder='e.g. ogr:geometryProperty' required />
          </div>
        </div>
             <div class="form-group">
            <label class="col-sm-2 control-label"  for='namespaces'>Pre-loaded Namespaces</label> 

            <div class="col-sm-10">
             <textarea type="text" rows="11"  class="form-control" id="preloaded" name='preloaded'    disabled>xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:imro="http://www.geonovum.nl/imro/2008/1"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:gml="http://www.opengis.net/gml"
xmlns:math="http://www.w3.org/2005/xpath-functions/math"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:strdf="http://www.strabon.di.uoa.gr/"</textarea>
                </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for='namespaces'>Namespaces</label> 

            <div class="col-sm-10">
            <textarea type="text" class="form-control" id="namespaces" name='namespaces' required placeholder="e.g. xmlns:ogr='http://ogr.maptools.org/'" ></textarea>
            </div>
            
        </div>
    <div class="form-group">
            <label class="col-sm-2 control-label" for='filetype'>Output Filetype</label> 

            <div class="col-sm-10">
                <select type="text" class="form-control" id="filetype" name='filetype' required  >
                    <option value="rdf" >RDF/XML</option>
                    <option value="n3">N3</option>
                    <option value="nt" >NT</option>
                    <option value="ttl" >TTL</option>
                </select>
            </div>
            
        </div>             
        <div class="form-group">
             <label class="col-sm-2 control-label"  required>Upload to server</label> 
         
            <div class='col-sm-offset-4  col-sm-6 checkbox'  >

        <label><input id='serverupload' name='serverupload' type="checkbox" >Upload to server </label>

    </div></div>
         <div class="form-group">
             <label class="col-sm-2 control-label"  required>Transform to WKT </label> 
         
            <div class='col-sm-offset-4  col-sm-6 checkbox'  >

        <label><input id='serverupload' name='kwt' type="checkbox" > Transform to WKT ? </label>

    </div></div>
            <div class="form-group">
            <label class="col-sm-2 control-label" for='serverurl'>Server URL</label> 
             <div class="col-sm-10">
                 <INPUT  type="text" id="serverurl" class="form-control" name='serverurl'  placeholder='e.g. http://localhost'  />
          </div>
            
        <div class="form-group">
            <label class="col-sm-2 control-label" for='fileToUpload' required>Select file</label> 
             <div class="col-sm-offset-4  col-sm-6">
      <INPUT type='file' name='fileToUpload' required class="input-file"  id='fileToUpload' onchange='fileSelected();' />  
      </div>
        </div>

        <div class="form-group">
             <div class="col-sm-offset-6 col-sm-6">
                 <button type="submit" id='bt1' class="btn btn-default">Submit</button>
          </div>
        </div>
           </br>
    <div id='prbar'></div>
    <div id='fileSize'></div>
        
    </form>

    <%@include file="footer.jsp" %>