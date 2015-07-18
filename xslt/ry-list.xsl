<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dco="&dco;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/ry-list-item.xsl"/>

  <xsl:template name="ry-list">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:choose>
      <xsl:when test="$node//dco:ReportingYear|$node//*/rdf:type[@rdf:resource='&dco;ReportingYear']">
	    <xsl:for-each select="$node//dco:ReportingYear[@rdf:about]|$node//*[rdf:type/@rdf:resource='&dco;ReportingYear' and @rdf:about]">
	      <xsl:sort select="dco:startsOn"/>
	      <xsl:call-template name="ry-list-item">
			<xsl:with-param name="admin" select="$admin"/>
			<xsl:with-param name="node" select="current()"/>
	      </xsl:call-template>
	    </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	    <p xmlns="http://www.w3.org/1999/xhtml">There are no Reporting Years entered for this Entity</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="ry-list">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="node" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
