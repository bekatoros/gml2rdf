<xsl:copy-of select="child::*/child::*"/>   
</strdf:hasGeometry>

</xsl:if>



</rdf:Description>

<!--</xsl:if>-->
</xsl:template>


<!-- template for srsName GML property
This template matches the srsName attribute and transforms this to an RDF property named gml:srsName. The
URN that refers to the coordinate reference system is contained in rdf:resource. -->


<xsl:template match="@srsName">
<gml:srsName rdf:resource="http://www.strabon.di.uoa.gr#{.}"/>
</xsl:template>
<!-- template for description GML property
This template matches the gml:description element and transforms this to rdfs:comment. -->
<xsl:template match="gml:description">
<rdfs:comment><xsl:value-of select="text()"/></rdfs:comment>
</xsl:template>

<xsl:template match=" *[count(ancestor::*) mod 2 != 0  and not(child::*)  ]">
<xsl:element name="{name()}">
<xsl:value-of select="text()"/>
</xsl:element>
</xsl:template>

<xsl:template match="  *[count(ancestor::*) mod 2 != 0   and child::*  ]">
<xsl:for-each select="*">
<xsl:element name="{parent::*/name()}">
<xsl:attribute name="rdf:resource" select="concat('#', if (@gml:id) then
@gml:id else generate-id(.))"></xsl:attribute>
</xsl:element>
</xsl:for-each>
</xsl:template>

<xsl:template match="*[count(ancestor::*) mod 2 != 0 and normalize-space(@xlink:href)  ]">
<xsl:element name="{name()}">
<xsl:attribute name="rdf:resource" select="@xlink:href"/>
</xsl:element>


</xsl:template>

<xsl:template match="//*[(ancestor::