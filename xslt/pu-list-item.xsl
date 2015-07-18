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

  <xsl:import href="/xslt/pu-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>

  <xsl:template name="pu-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="label">
      <xsl:call-template name="get-pu-label">
		<xsl:with-param name="pu" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    Label: <xsl:value-of select="$label"/>
	<br/>

    <xsl:variable name="submitted">
      <xsl:call-template name="get-pu-date">
		<xsl:with-param name="pu" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="submittedStr">
	  <xsl:call-template name="get-date-monthabrev">
	    <xsl:with-param name="dt" select="$submitted"/>
	  </xsl:call-template>
	</xsl:variable>
	Submitted On: <xsl:value-of select="$submittedStr"/>
	<br/>

    <xsl:variable name="text">
      <xsl:call-template name="get-pu-text">
		<xsl:with-param name="pu" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<div id="dialog">
	<h3>Update Description:</h3>
	<div>
	<xsl:value-of disable-output-escaping="yes" select="string($text)"/>
	</div>
	</div>
  </xsl:template>

</xsl:stylesheet>
