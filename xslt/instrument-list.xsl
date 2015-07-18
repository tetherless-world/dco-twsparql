<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY obo "http://purl.obolibrary.org/obo/">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dco="&dco;"
   xmlns:vivo="&vivo;"
   xmlns:obo="&obo;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/instrument-list-item.xsl"/>

  <xsl:template name="instrument-list">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>
    <xsl:choose>
      <xsl:when test="$root//obo:ERO_0000004|$root//*/rdf:type[@rdf:resource='&obo;ERO_0000004']">
	    <xsl:for-each select="$root//obo:ERO_0000004[@rdf:about]|$root//*[rdf:type/@rdf:resource='&obo;ERO_0000004' and @rdf:about]">
	      <xsl:sort select="rdfs:label"/>
	      <xsl:call-template name="instrument-list-item">
			<xsl:with-param name="admin" select="$admin"/>
			<xsl:with-param name="node" select="current()"/>
			<xsl:with-param name="root" select="$root"/>
			<xsl:with-param name="title" select='"Instrument"'/>
	      </xsl:call-template>
	    </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	    <p xmlns="http://www.w3.org/1999/xhtml">There are no Instruments entered for this Entity</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="instrument-list">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>

