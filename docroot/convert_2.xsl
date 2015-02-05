
exclude-result-prefixes="xs"
version="2.0">
<xsl:output indent="yes"/>
<xsl:strip-space elements="*"/>


<!--<xsl:template match="ogr:geometryProperty">
<strdf:hasGeometry>
    <xsl:copy-of select="*">     </xsl:copy-of>
</strdf:hasGeometry>
</xsl:template>
-->

<xsl:template match="/ "><rdf:RDF>
 <xsl:apply-templates select="//*[count(ancestor::*) mod 2 = 0] "/> <!---->
</rdf:RDF></xsl:template>





<!-- template for features / resources.
This template matches all elements that have an even number of ancestors: the Classes. These are transformed to
rdf:Description. The rdf:about attribute is filled with gml:id if it’s present; if not, an id is generated.
@srsName and the properties are then processed ( apply-templates). -->
<xsl:template match="*[count(ancestor::*) mod 2 = 0 ]  ">

<rdf:Description rdf:about="http://strdf.di.uoa.gr/ontology#{if (@gml:id) then @gml:id else generate-id(.)}"  rdf:type="http://www.opengis.net/gml#{local-name()}">

<xsl:apply-templates/>
<xsl:apply-templates select="@srsName"/>


 <!-- mallon to eftiaxa prepei na to dokimasw sto strabon -->


<xsl:if test="