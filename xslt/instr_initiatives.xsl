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

  <xsl:import href="/xslt/initiative-common.xsl"/>
  <xsl:import href="/xslt/community-common.xsl"/>
  <xsl:import href="/xslt/team-common.xsl"/>
  <xsl:import href="/xslt/vcard-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/pub-common.xsl"/>

  <xsl:template name="instr_initiative-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="initiative"/>
    <xsl:param name="root"/>

    <blockquote style="overflow:auto;">
      <xsl:call-template name="place-initiative-title">
        <xsl:with-param name="initiative" select="$initiative"/>
      </xsl:call-template>

      <xsl:call-template name="place-image">
        <xsl:with-param name="node" select="$initiative"/>
        <xsl:with-param name="style" select='"max-width:30%;height:auto;float:left;margin:5px 1px;"'/>
      </xsl:call-template>

      <xsl:call-template name="place-initiative-description">
        <xsl:with-param name="initiative" select="$initiative"/>
      </xsl:call-template>

      <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
      <p><a style="font-size:120%;" href="/instr-initiative?uri={$initiativeuri}">read more...</a></p>
    </blockquote>

  </xsl:template>

  <xsl:template name="instr_initiatives">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>
    <xsl:choose>
      <xsl:when test="$root//dco:InstrumentInitiative|$root//*/rdf:type[@rdf:resource='&dco;InstrumentInitiative']">
	    <xsl:for-each select="$root//dco:InstrumentInitiative[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;InstrumentInitiative' and @rdf:about]">
	      <xsl:sort select="dco:importance" order="descending" data-type="number"/>
	      <xsl:call-template name="instr_initiative-list-item">
			<xsl:with-param name="admin" select="$admin"/>
			<xsl:with-param name="initiative" select="current()"/>
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
    <xsl:call-template name="instr_initiatives">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
