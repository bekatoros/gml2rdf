<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:imro="http://www.geonovum.nl/imro/2008/1"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:gml="http://www.opengis.net/gml"
xmlns:math="http://www.w3.org/2005/xpath-functions/math"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:strdf="http://strdf.di.uoa.gr/ontology#"
xmlns:geo="http://www.opengis.net/ont/geosparql#"
xmlns:ogr="http://ogr.maptools.org/"

 
exclude-result-prefixes="xs"
version="2.0">
<xsl:output indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="@*|node()">
<xsl:copy>
		<xsl:apply-templates select="@*|node()" />     		<!-- May involve either a gml:Box (older specification) or a gml:Envelope (latest OGC standard) -->
</xsl:copy>
</xsl:template>


<xsl:template match="gml:boundedBy"></xsl:template>

</xsl:stylesheet>
