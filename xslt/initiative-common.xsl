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

  <xsl:template name="place-initiative-label">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <xsl:variable name="initiativeobj" select="key('dco:InstrumentInitiative-nodes',$initiativeuri)"/>
    <h3><a href="{$initiativeuri}"><xsl:value-of select="$initiativeobj/rdfs:label"/></a></h3>
  </xsl:template>

  <xsl:template name="place-initiative-description">
    <xsl:param name="initiative"/>
    <xsl:variable name="initiativeuri" select="$initiative/@rdf:resource|$initiative/@rdf:about"/>
    <xsl:variable name="initiativeobj" select="key('dco:InstrumentInitiative-nodes',$initiativeuri)"/>
    <xsl:value-of select="$initiativeobj/vivo:description" disable-output-escaping="yes"/>
  </xsl:template>

</xsl:stylesheet>

