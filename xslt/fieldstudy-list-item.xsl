<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dco="&dco;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/project-list-item.xsl"/>
  <xsl:import href="/xslt/fieldstudy-common.xsl"/>

  <xsl:template name="fieldstudy-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root"/>

    <xsl:call-template name="project-list-item">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="$node"/>
      <xsl:with-param name="root" select="$root"/>
      <xsl:with-param name="title" select='"Field Study"'/>
    </xsl:call-template>
    <strong>Field Sites</strong>:

    <xsl:choose>
      <xsl:when test="$node/dco:hasPhysicalLocation">
        <xsl:for-each select="key('dco:PhysicalLocation-nodes',$node/dco:hasPhysicalLocation/@rdf:resource|$node/dco:hasPhysicalLocation/*/@rdf:about)">
          <xsl:sort select="rdfs:label"/>
          <xsl:value-of select="current()/rdfs:label"/>
          <xsl:if test="position() != last()">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <p> </p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
