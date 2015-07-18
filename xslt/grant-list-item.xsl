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
   xmlns:bibo="http://purl.org/ontology/bibo/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/grant-common.xsl"/>
  <xsl:import href="/xslt/community-common.xsl"/>
  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/pu-common.xsl"/>
  <xsl:import href="/xslt/ry-common.xsl"/>

  <xsl:template name="grant-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root"/>

    <div id="findings" style="width:95%"><p style="margin-top: 1em;margin-bottom: 0em;">

    <xsl:variable name="grant-url">
      <xsl:call-template name="get-grant-url">
        <xsl:with-param name="grant" select="$node"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:call-template name="get-grant-label">
		<xsl:with-param name="grant" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <a href="/dco_grant_summary?uri={$grant-url}"><xsl:value-of select="$label"/></a>
	<br/>

    <xsl:choose>
      <xsl:when test="$node/bibo:abstract">
        <span style="font-weight:bold;">Abstract: </span>
        <xsl:call-template name="get-grant-abstract">
          <xsl:with-param name="grant" select="$node"/>
        </xsl:call-template>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$node/dco:grantRecipient">
        <span style="font-weight:bold;">Recipient: </span>
        <xsl:call-template name="place-grant-recipient">
          <xsl:with-param name="grant" select="$node"/>
        </xsl:call-template>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$node/vivo:totalAwardAmount">
        <span style="font-weight:bold;">Total Award: </span>
        <xsl:call-template name="get-grant-award">
          <xsl:with-param name="grant" select="$node"/>
        </xsl:call-template>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$node/dco:associatedDCOCommunity">
        <span style="font-weight:bold;">DCO Communities: </span>
        <xsl:for-each select="$node/dco:associatedDCOCommunity">
	      <xsl:sort select="rdfs:label"/>
          <xsl:call-template name="place-community-label">
            <xsl:with-param name="community" select="current()"/>
          </xsl:call-template>
          <xsl:if test="position() != last()">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
        <br/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <span style="font-weight:bold;">DCO Projects, Field Studies or Instruments: </span>
    <xsl:variable name="set" select="$node/vivo:fundingVehicleFor" />
    <xsl:variable name="count" select="count($set)" />
    <xsl:value-of select="$count"/>
    <br/>

    <xsl:choose>
      <xsl:when test="key('dco:ReportingYear-nodes', key('dco:ProjectUpdate-nodes', key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/@rdf:resource|key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/*/@rdf:about) /dco:forReportingYear/@rdf:resource|key('dco:ProjectUpdate-nodes', key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/@rdf:resource|key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/*/@rdf:about)">

        <span style="font-weight:bold;">Grant Summaries: </span>
        <xsl:for-each select="key('dco:ReportingYear-nodes', key('dco:ProjectUpdate-nodes', key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/@rdf:resource|key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/*/@rdf:about) /dco:forReportingYear/@rdf:resource|key('dco:ProjectUpdate-nodes', key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/@rdf:resource|key('vivo:Project-nodes',$node/vivo:fundingVehicleFor/@rdf:resource|$node/dco:fundingVehicleFor/*/@rdf:about)/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/*/@rdf:about)">
          <xsl:sort select="dco:startsOn"/>

          <xsl:variable name="ry_uri">
            <xsl:value-of select="current()/@rdf:about"/>
          </xsl:variable>

          <a href="/dco_grant_summary?uri={$grant-url}&amp;ry={$ry_uri}"><xsl:value-of select="current()/rdfs:label"/></a>

          <xsl:if test="position() != last()">
            <xsl:text>; </xsl:text>
          </xsl:if>

        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </p></div>

  </xsl:template>

</xsl:stylesheet>
