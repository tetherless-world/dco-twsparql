<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY dcodata "http://info.deepcarbon.net/data/schema#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:dcodata="&dcodata;"
		xmlns:foaf="&foaf;"
		xmlns:vivo="&vivo;"
		xmlns:ero="&ero;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:key name="dcodata:Dataset-nodes" match="dcodata:Dataset|*[rdf:type/@rdf:resource='&dcodata;Dataset']" use="@rdf:about"/>
  <xsl:key name="dcodata:Distribution-nodes" match="dcodata:Distribution|*[rdf:type/@rdf:resource='&dcodata;Distribution']" use="@rdf:about"/>
  <xsl:key name="dcodata:Creator-nodes" match="dcodata:Creator|*[rdf:type/@rdf:resource='&dcodata;Creator']" use="@rdf:about"/>
  <xsl:key name="dcodata:Contributor-nodes" match="dcodata:Contributor|*[rdf:type/@rdf:resource='&dcodata;Contributor']" use="@rdf:about"/>
  <xsl:key name="foaf:Document-nodes" match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" use="@rdf:about"/>

  <xsl:template name="place-dataset-label">
    <xsl:param name="dataset"/>
    <xsl:param name="style"/>
    <xsl:variable name="dataseturi" select="$dataset/@rdf:about"/>
    <xsl:variable name="datasetlabel" select="$dataset/rdfs:label"/>
    <a href="{$dataseturi}" style="{$style}"><xsl:value-of select="$datasetlabel"/></a>
  </xsl:template>

  <xsl:template name="place-dataset-author">
    <xsl:param name="creator"/>
    <xsl:variable name="person" select="key('foaf:Person-nodes',$creator/vivo:relates/@rdf:resource)"/>
    <xsl:variable name="person_url" select="$person/@rdf:about"/>

    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:variable name="last" select="substring-before($person/rdfs:label,',')"/>
    <xsl:variable name="after" select="normalize-space(substring-after($person/rdfs:label,','))"/>

    <xsl:variable name="first">
      <xsl:choose>
        <xsl:when test="contains($after,' ')">
          <xsl:value-of select="substring-before($after,' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$after"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="fi" select="translate(substring($first,1,1),$smallcase,$uppercase)"/>

    <xsl:variable name="mi">
      <xsl:choose>
        <xsl:when test="contains($after,' ')">
          <xsl:value-of select="translate(substring(substring-after($after,' '),1,1),$smallcase,$uppercase)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="$last"/><xsl:text> </xsl:text><xsl:value-of select="$fi"/><xsl:value-of select="$mi"/>
  </xsl:template>

  <xsl:template name="place-dataset-authors">
    <xsl:param name="dataset"/>
    <xsl:for-each select="key('dcodata:Creator-nodes',$dataset/vivo:relatedBy/@rdf:resource)">
      <xsl:sort select="vivo:rank"/>
      <xsl:call-template name="place-dataset-author">
        <xsl:with-param name="creator" select="current()"/>
      </xsl:call-template>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>. </xsl:text>
  </xsl:template>

  <xsl:template name="place-creators">
    <xsl:param name="dataset"/>
    <xsl:choose>
      <xsl:when test="key('dcodata:Creator-nodes',$dataset/vivo:relatedBy/@rdf:resource)">
        <br/>
        <span style="font-weight:bold;font-size:120%;">Dataset Creators:</span>
        <ul>
        <xsl:for-each select="key('dcodata:Creator-nodes',$dataset/vivo:relatedBy/@rdf:resource)">
          <xsl:sort select="vivo:rank"/>
          <li>
            <xsl:variable name="person" select="key('foaf:Person-nodes',current()/vivo:relates/@rdf:resource)"/>
            <xsl:call-template name="place-person-link">
              <xsl:with-param name="person" select="$person"/>
            </xsl:call-template>
          </li>
        </xsl:for-each>
        </ul>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-contributors">
    <xsl:param name="dataset"/>
    <xsl:choose>
      <xsl:when test="key('dcodata:Contributor-nodes',$dataset/vivo:relatedBy/@rdf:resource)">
        <br/>
        <span style="font-weight:bold;font-size:120%;">Dataset Contributors:</span>
        <ul>
        <xsl:for-each select="key('dcodata:Contributor-nodes',$dataset/vivo:relatedBy/@rdf:resource)">
          <xsl:sort select="vivo:rank"/>
          <li>
            <xsl:variable name="person" select="key('foaf:Person-nodes',current()/vivo:relates/@rdf:resource)"/>
            <xsl:call-template name="place-person-link">
              <xsl:with-param name="person" select="$person"/>
            </xsl:call-template>
          </li>
        </xsl:for-each>
        </ul>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-distribution-link">
    <xsl:param name="distribution"/>
    <xsl:param name="style"/>
    <xsl:variable name="distribution_url" select="$distribution/@rdf:about"/>
    <xsl:variable name="distribution_label" select="$distribution/rdfs:label"/>
    <a href="{$distribution_url}" style="{$style}"><xsl:value-of select="$distribution_label"/></a>
  </xsl:template>

</xsl:stylesheet>
