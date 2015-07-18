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

  <xsl:key name="dco:ReportingYear-nodes" match="dco:ReportingYear|*[rdf:type/@rdf:resource='&dco;ReportingYear']" use="@rdf:about"/>

  <xsl:template name="get-ry-label">
    <xsl:param name="ry"/>
    <xsl:value-of select="$ry/rdfs:label[@xml:lang='en-US']|$ry/rdfs:label"/>
  </xsl:template>

  <xsl:template name="get-ry-start">
    <xsl:param name="ry"/>
    <xsl:value-of select="$ry/dco:startsOn"/>
  </xsl:template>

  <xsl:template name="get-ry-end">
    <xsl:param name="ry"/>
    <xsl:value-of select="$ry/dco:endsOn"/>
  </xsl:template>

</xsl:stylesheet>
