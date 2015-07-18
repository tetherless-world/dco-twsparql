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
		xmlns:bibo="http://purl.org/ontology/bibo/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:key name="vivo:Grant-nodes" match="vivo:Grant|*[rdf:type/@rdf:resource='&vivo;Grant']" use="@rdf:about"/>

  <xsl:template name="get-grant-label">
    <xsl:param name="grant"/>
    <xsl:value-of select="$grant/rdfs:label[@xml:lang='en-US']|$grant/rdfs:label"/>
  </xsl:template>

  <xsl:template name="get-grant-description">
    <xsl:param name="grant"/>
    <xsl:choose>
      <xsl:when test="$grant/vivo:description/*">
        <xsl:copy-of select="$grant/vivo:description/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$grant/vivo:description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-grant-url">
    <xsl:param name="grant"/>
    <xsl:value-of select="$grant/@rdf:about"/>
  </xsl:template>

  <xsl:template name="get-grant-abstract">
    <xsl:param name="grant"/>
    <xsl:value-of disable-output-escaping="yes" select="$grant/bibo:abstract[@xml:lang='en-US']|$grant/bibo:abstract"/>
  </xsl:template>

  <xsl:template name="place-grant-recipient">
    <xsl:param name="grant"/>
    <xsl:variable name="personuri" select="$grant/dco:grantRecipient/@rdf:resource"/>
    <xsl:variable name="person" select="key('foaf:Person-nodes',$personuri)"/>
    <a href="{$personuri}"><xsl:value-of select="$person/rdfs:label"/></a>
  </xsl:template>

  <xsl:template name="get-grant-award">
    <xsl:param name="grant"/>
    <xsl:value-of select="$grant/vivo:totalAwardAmount"/>
  </xsl:template>

</xsl:stylesheet>

