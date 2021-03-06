<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:foaf="&foaf;"
		xmlns:vivo="&vivo;"
		xmlns:ero="&ero;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="dco:DataType-nodes" match="dco:DataType|*[rdf:type/@rdf:resource='&dco;DataType']" use="@rdf:about"/>

  <xsl:template name="place-dtype-link">
    <xsl:param name="dtype"/>
    <xsl:variable name="dtype_url" select="$dtype/@rdf:about"/>
    <a href="{$dtype_url}"><xsl:value-of select="$dtype/rdfs:label"/></a>
  </xsl:template>

</xsl:stylesheet>
