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

  <xsl:key name="vivo:Role-nodes" match="vivo:Role|*[rdf:type/@rdf:resource='&vivo;Role']" use="@rdf:about"/>
  <xsl:key name="foaf:Person-nodes" match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']" use="@rdf:about"/>
  <xsl:key name="foaf:Agent-nodes" match="foaf:Agent|*[rdf:type/@rdf:resource='&foaf;Agent']" use="@rdf:about"/>
  <xsl:key name="dco:POC-nodes" match="dco:PointOfContact|*[rdf:type/@rdf:resource='&dco;PointOfContact']" use="@rdf:about"/>

  <xsl:template name="place-pocs">
    <xsl:param name="entity"/>
    <xsl:choose>
      <xsl:when test="$entity/dco:hasPointOfContact">
        <span style="font-size:120%;">Contact Information:</span>
        <ul>
        <xsl:for-each select="key('dco:POC-nodes',$entity/dco:hasPointOfContact/@rdf:resource)">
          <li>
          <xsl:call-template name="place-poc">
            <xsl:with-param name="poc" select="current()"/>
          </xsl:call-template>
          </li>
        </xsl:for-each>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-poc">
    <xsl:param name="poc"/>
    <xsl:variable name="agent" select="key('foaf:Agent-nodes',$poc/dco:hasContact/@rdf:resource)"/>
    <xsl:variable name="agent_url" select="$agent/@rdf:about"/>
    <a href="{$agent_url}"><xsl:value-of select="$agent/rdfs:label"/></a><xsl:text>: </xsl:text><xsl:value-of select="$poc/dco:hasContactInformation" disable-output-escaping="yes"/>
  </xsl:template>

</xsl:stylesheet>
