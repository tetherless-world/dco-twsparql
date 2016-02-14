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
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="dco:Team-nodes" match="dco:Team|*[rdf:type/@rdf:resource='&dco;Team']" use="@rdf:about"/>

  <xsl:template name="place-team-label">
    <xsl:param name="team"/>
    <xsl:variable name="teamuri" select="$team/@rdf:resource"/>
    <xsl:variable name="teamobj" select="key('dco:Team-nodes',$teamuri)"/>
    <a href="{$teamuri}"><xsl:value-of select="$teamobj/rdfs:label"/></a>
  </xsl:template>

</xsl:stylesheet>

