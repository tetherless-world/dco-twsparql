<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:vivo="&vivo;"
		xmlns:foaf="&foaf;"
		xmlns:ero="&ero;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="vivo:Instrument-nodes" match="ero:ERO_0000004|*[rdf:type/@rdf:resource='&ero;ERO_0000004']" use="@rdf:about"/>

  <xsl:template name="get-instrument-label">
    <xsl:param name="instrument"/>
    <xsl:value-of select="$instrument/rdfs:label[@xml:lang='en-US']|$instrument/rdfs:label"/>
  </xsl:template>

  <xsl:template name="get-instrument-description">
    <xsl:param name="instrument"/>
    <xsl:choose>
      <xsl:when test="$instrument/vivo:description/*">
        <xsl:copy-of select="$instrument/vivo:description/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$instrument/vivo:description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-instrument-url">
    <xsl:param name="instrument"/>
    <xsl:value-of select="$instrument/@rdf:about"/>
  </xsl:template>

</xsl:stylesheet>

