<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="dco:ProjectUpdate-nodes" match="dco:ProjectUpdate|*[rdf:type/@rdf:resource='&dco;ProjectUpdate']" use="@rdf:about"/>

  <xsl:template name="get-pu-label">
    <xsl:param name="pu"/>
    <xsl:value-of select="$pu/rdfs:label[@xml:lang='en-US']|$pu/rdfs:label"/>
  </xsl:template>

  <xsl:template name="get-pu-url">
    <xsl:param name="pu"/>
    <xsl:value-of select="$pu/@rdf:about|$pu/@rdf:nodeID"/>
  </xsl:template>

  <xsl:template name="get-pu-text">
    <xsl:param name="pu"/>
    <xsl:choose>
      <xsl:when test="$pu/dco:updateText/*">
        <xsl:copy-of select="$pu/dco:updateText/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$pu/dco:updateText"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-pu-date">
    <xsl:param name="pu"/>
    <xsl:value-of select="$pu/dco:submittedOn"/>
  </xsl:template>

  <xsl:template name="get-pu-project-url">
    <xsl:param name="node"/>
    <xsl:value-of select="$node//dco:forProject/@rdf:resource|$node//dco:forProject/@rdf:resource"/>
  </xsl:template>

</xsl:stylesheet>

