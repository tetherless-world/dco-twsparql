<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
  <!ENTITY skos "http://www.w3.org/2004/02/skos/core#">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:foaf="&foaf;"
		xmlns:vivo="&vivo;"
		xmlns:ero="&ero;"
		xmlns:skos="&skos;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="skos:Concept-nodes" match="skos:Concept|*[rdf:type/@rdf:resource='&skos;Concept']" use="@rdf:about"/>

  <xsl:template name="place-concept-profile-link">
    <xsl:param name="concept"/>
    <xsl:variable name="concept_url" select="$concept/@rdf:about"/>
    <a href="{$concept_url}"><xsl:value-of select="$concept/rdfs:label"/></a>
  </xsl:template>

  <xsl:template name="place-subject-areas">
    <xsl:param name="entity"/>
    <xsl:choose>
      <xsl:when test="$entity/vivo:hasSubjectArea">
        <p><span style="font-weight:bold;">Studies Of</span>:
        <xsl:for-each select="key('skos:Concept-nodes',$entity/vivo:hasSubjectArea/@rdf:resource)">
          <xsl:sort select="rdfs:label"/>
          <xsl:call-template name="place-concept-profile-link">
            <xsl:with-param name="concept" select="current()"/>
          </xsl:call-template>
          <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
