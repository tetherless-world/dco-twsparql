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

  <xsl:import href="/xslt/ry-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>

  <xsl:template name="ry-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>

    <xsl:variable name="label">
      <xsl:call-template name="get-ry-label">
		<xsl:with-param name="ry" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    Label: <xsl:value-of select="$label"/>
	<br/>

    <xsl:variable name="startsOn">
      <xsl:call-template name="get-ry-start">
		<xsl:with-param name="ry" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="startsOnStr">
	  <xsl:call-template name="get-date-monthabrev">
	    <xsl:with-param name="dt" select="$startsOn"/>
	  </xsl:call-template>
	</xsl:variable>
	Starts On: <xsl:value-of select="$startsOnStr"/>
	<br/>

    <xsl:variable name="endsOn">
      <xsl:call-template name="get-ry-end">
		<xsl:with-param name="ry" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="endsOnStr">
	  <xsl:call-template name="get-date-monthabrev">
	    <xsl:with-param name="dt" select="$endsOn"/>
	  </xsl:call-template>
	</xsl:variable>
	Ends On: <xsl:value-of select="$endsOnStr"/>
	<br/>

  </xsl:template>

</xsl:stylesheet>
