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
  <xsl:import href="/xslt/concept-common.xsl"/>

  <xsl:template name="instr_initiative_areas">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>

    <xsl:choose>
      <xsl:when test="$root//dco:InstrumentInitiative[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;InstrumentInitiative' and @rdf:about]">
        <xsl:variable name="initiative" select="$root//dco:InstrumentInitiative[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;InstrumentInitiative' and @rdf:about]"/>

          <xsl:call-template name="place-subject-areas">
            <xsl:with-param name="entity" select="$initiative"/>
          </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="instr_initiative_areas">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
