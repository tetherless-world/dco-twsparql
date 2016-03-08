<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:vivo="&vivo;"
		xmlns:foaf="&foaf;"
		xmlns:ero="&ero;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:bibo="http://purl.org/ontology/bibo/"
        xmlns:obo="http://purl.obolibrary.org/obo/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="dco:InstrumentInitiative-nodes" match="dco:InstrumentInitiative|*[rdf:type/@rdf:resource='&dco;InstrumentInitiative']" use="@rdf:about"/>
  <xsl:key name="dco:Instrument-nodes" match="dco:Instrument|*[rdf:type/@rdf:resource='&dco;Instrument']" use="@rdf:about"/>

  <xsl:template name="place-initiative-profile-link">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <div><a href="{$initiativeuri}">Instrument Metadata</a></div>
  </xsl:template>

  <xsl:template name="place-instrument-profile-link">
    <xsl:param name="instrument"/>
    <xsl:variable name="instrumenturi" select="$instrument/@rdf:resource|$instrument/@rdf:about"/>
    <div><a href="{$instrumenturi}">Instrument Metadata</a></div>
  </xsl:template>

  <xsl:template name="place-initiative-title">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <xsl:variable name="initiativeobj" select="key('dco:InstrumentInitiative-nodes',$initiativeuri)"/>
    <h2><xsl:value-of select="$initiativeobj/rdfs:label"/></h2>
  </xsl:template>

  <xsl:template name="place-initiative-summary-link">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <xsl:variable name="initiativeobj" select="key('dco:InstrumentInitiative-nodes',$initiativeuri)"/>
    <h2><a href="/page/instr-initiative?uri={$initiativeuri}"><xsl:value-of select="$initiativeobj/rdfs:label"/></a></h2>
  </xsl:template>

  <xsl:template name="place-initiative-description">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <xsl:variable name="initiativeobj" select="key('dco:InstrumentInitiative-nodes',$initiativeuri)"/>
    <xsl:value-of select="$initiativeobj/vivo:description" disable-output-escaping="yes"/>
  </xsl:template>

  <xsl:template name="place-instrument-description">
    <xsl:param name="instrument"/>
    <xsl:variable name="instrumenturi" select="$instrument/@rdf:resource|$instrument/@rdf:about"/>
    <xsl:variable name="instrumentobj" select="key('dco:Instrument-nodes',$instrumenturi)"/>
    <xsl:value-of select="$instrumentobj/vivo:description" disable-output-escaping="yes"/>
  </xsl:template>

</xsl:stylesheet>

