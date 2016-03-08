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

  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/initiative-common.xsl"/>

  <xsl:template name="instr_built-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="built"/>
    <xsl:param name="root"/>

    <!--
    <h4 style="font-size:120%;"><xsl:value-of select="$built/rdfs:label"/></h4>


    <xsl:call-template name="place-instrument-profile-link">
      <xsl:with-param name="instrument" select="$built"/>
    </xsl:call-template>
    -->
    <blockquote style="display:block;margin-top: 1em;margin-bottom: 1em;">
      <xsl:call-template name="place-instrument-description">
        <xsl:with-param name="instrument" select="$built"/>
      </xsl:call-template>
      <xsl:call-template name="place-pocs">
        <xsl:with-param name="entity" select="$built"/>
      </xsl:call-template>
    </blockquote>

  </xsl:template>

  <xsl:template name="instr_builts">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>
    <xsl:choose>
      <xsl:when test="$root//dco:Instrument|$root//*/rdf:type[@rdf:resource='&dco;Instrument']">
	    <xsl:for-each select="$root//dco:Instrument[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;Instrument' and @rdf:about]">
	      <xsl:sort select="rdfs:label"/>
	      <xsl:call-template name="instr_built-list-item">
			<xsl:with-param name="admin" select="$admin"/>
			<xsl:with-param name="built" select="current()"/>
			<xsl:with-param name="root" select="$root"/>
	      </xsl:call-template>
	    </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	    <p> </p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="instr_builts">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
