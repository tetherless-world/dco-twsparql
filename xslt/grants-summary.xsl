<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dco="&dco;"
   xmlns:vivo="&vivo;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/grant-list-item.xsl"/>

  <xsl:template name="grants-summary">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>
    <xsl:choose>
      <xsl:when test="$root//vivo:Grant|$root//*/rdf:type[@rdf:resource='&vivo;Grant']">
	    <xsl:for-each select="$root//vivo:Grant[@rdf:about]|$root//*[rdf:type/@rdf:resource='&vivo;Grant' and @rdf:about]">
	      <xsl:sort select="rdfs:label"/>
	      <xsl:call-template name="grant-list-item">
			<xsl:with-param name="admin" select="$admin"/>
			<xsl:with-param name="node" select="current()"/>
			<xsl:with-param name="root" select="$root"/>
	      </xsl:call-template>
          <br/>
	    </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	    <p> </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="grants-summary">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
