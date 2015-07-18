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

  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:key name="vivo:Project-nodes" match="vivo:Project|*[rdf:type/@rdf:resource='&vivo;Project']" use="@rdf:about"/>
  <xsl:key name="vivo:DateTimeInterval-nodes" match="vivo:DateTimeInterval|*[rdf:type/@rdf:resource='&vivo;DateTimeInterval']" use="@rdf:about"/>
  <xsl:key name="vivo:DateTimeValue-nodes" match="vivo:DateTimeValue|*[rdf:type/@rdf:resource='&vivo;DateTimeValue']" use="@rdf:about"/>

  <xsl:template name="get-project-label">
    <xsl:param name="project"/>
    <xsl:value-of select="$project/rdfs:label[@xml:lang='en-US']|$project/rdfs:label"/>
  </xsl:template>

  <xsl:template name="get-project-description">
    <xsl:param name="project"/>
    <xsl:choose>
      <xsl:when test="$project/vivo:description/*">
        <xsl:copy-of select="$project/vivo:description/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$project/vivo:description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-project-url">
    <xsl:param name="project"/>
    <xsl:value-of select="$project/@rdf:about"/>
  </xsl:template>

  <xsl:template name="display-project-pis">
    <xsl:param name="project"/>
    <xsl:for-each select="$project/ero:BFO_0000052/@rdf:resource|$project/vivo:contributingRole/@rdf:resource">
      <xsl:variable name="role" select="key('vivo:Role-nodes',current())"/>
      <xsl:variable name="personuri" select="$role/ero:RO_0000052/@rdf:resource"/>
      <xsl:variable name="person" select="key('foaf:Person-nodes',$personuri)"/>
      <xsl:value-of select="$person/rdfs:label"/>
      <xsl:text>; </xsl:text>
      <xsl:if test="position() != last()">
        <xsl:text>; </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-project-start">
    <xsl:param name="project"/>
	<xsl:variable name="dtiuri" select="$project/vivo:dateTimeInterval/@rdf:resource"/>
	<xsl:variable name="dti" select="key('vivo:DateTimeInterval-nodes',$dtiuri)"/>
    <xsl:variable name="start" select="$dti/vivo:start/@rdf:resource"/>
	<xsl:variable name="dtv" select="key('vivo:DateTimeValue-nodes',$start)"/>
	<xsl:variable name="dt" select="$dtv/vivo:dateTime"/>
    <xsl:value-of select="$dt"/>
  </xsl:template>

  <xsl:template name="get-project-end">
    <xsl:param name="project"/>
	<xsl:variable name="dtiuri" select="$project/vivo:dateTimeInterval/@rdf:resource"/>
	<xsl:variable name="dti" select="key('vivo:DateTimeInterval-nodes',$dtiuri)"/>
    <xsl:variable name="end" select="$dti/vivo:end/@rdf:resource"/>
	<xsl:variable name="dtv" select="key('vivo:DateTimeValue-nodes',$end)"/>
	<xsl:variable name="dt" select="$dtv/vivo:dateTime"/>
    <xsl:value-of select="$dt"/>
  </xsl:template>

</xsl:stylesheet>
