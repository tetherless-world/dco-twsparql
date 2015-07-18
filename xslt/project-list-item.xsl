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

  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>
  <xsl:import href="/xslt/pu-common.xsl"/>
  <xsl:import href="/xslt/ry-common.xsl"/>

  <xsl:template name="pu-list">
    <xsl:param name="admin"/>
    <xsl:param name="project"/>
    <xsl:param name="ry"/>
    <xsl:param name="root"/>
    <xsl:param name="title"/>

    <xsl:variable name="ry_uri">
      <xsl:value-of select="$ry/@rdf:about"/>
    </xsl:variable>

    <xsl:variable name="ry_label">
      <xsl:call-template name="get-ry-label">
        <xsl:with-param name="ry" select="$ry"/>
      </xsl:call-template>
    </xsl:variable>
    <div class="dialog">
    <h3><span style="font-size:10pt;"><xsl:value-of select="$ry_label"/></span><span style="font-size:5pt;">  Click to expand</span></h3>

    <ul class="pu">

      <xsl:for-each select="key('dco:ProjectUpdate-nodes',$project/dco:hasProjectUpdate/@rdf:resource|$project/dco:hasProjectUpdate/*/@rdf:about)">
        <xsl:sort select="dco:submittedOn"/>

        <xsl:variable name="pu_ry_uri">
          <xsl:value-of select="./dco:forReportingYear/@rdf:resource"/>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="$ry_uri = $pu_ry_uri">

            <xsl:variable name="plabel">
              <xsl:call-template name="get-pu-label">
                <xsl:with-param name="pu" select="current()"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="pu_url">
              <xsl:call-template name="get-pu-url">
                <xsl:with-param name="pu" select="current()"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="submitted">
              <xsl:call-template name="get-pu-date">
                <xsl:with-param name="pu" select="current()"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="submittedStr">
              <xsl:call-template name="get-date-monthabrev">
                <xsl:with-param name="dt" select="$submitted"/>
              </xsl:call-template>
            </xsl:variable>

            <li class="pu"><a href="{$pu_url}"><xsl:value-of select="$plabel"/></a> - submitted on <xsl:value-of select="$submittedStr"/>

            <xsl:variable name="text">
              <xsl:call-template name="get-pu-text">
                <xsl:with-param name="pu" select="current()"/>
              </xsl:call-template>
            </xsl:variable>
            <h4 style="padding-left:20px;font-weight:10pt;"><xsl:value-of select="$title"/> Update Details:</h4>
            <div style="padding-left:20px;">
            <xsl:value-of disable-output-escaping="yes" select="string($text)"/>
            </div>
            </li>
          </xsl:when>
          <xsl:otherwise>
            <p> </p>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </ul>
    </div>
  </xsl:template>

  <xsl:template name="project-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root"/>
    <xsl:param name="title"/>

    <xsl:variable name="project-url">
      <xsl:call-template name="get-project-url">
        <xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:call-template name="get-project-label">
		<xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$title='Project'">
        <div class="proj_title"><a href="/dco_project_summary?uri={$project-url}"><xsl:value-of select="$label"/></a></div>
      </xsl:when>
      <xsl:otherwise>
        <div class="proj_title"><a href="/dco_field_study_summary?uri={$project-url}"><xsl:value-of select="$label"/></a></div>
      </xsl:otherwise>
    </xsl:choose>
	<br/>

    <strong>Project Investigators</strong>:
    <xsl:call-template name="display-project-pis">
      <xsl:with-param name="project" select="$node"/>
    </xsl:call-template>
	<br/>

    <xsl:variable name="startsOn">
      <xsl:call-template name="get-project-start">
		<xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="startsOnStr">
	  <xsl:call-template name="get-date-monthabrev">
	    <xsl:with-param name="dt" select="$startsOn"/>
	  </xsl:call-template>
	</xsl:variable>
	<strong>Start Date</strong>: <xsl:value-of select="$startsOnStr"/>
	<br/>

    <xsl:variable name="endsOn">
      <xsl:call-template name="get-project-end">
		<xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<xsl:variable name="endsOnStr">
	  <xsl:call-template name="get-date-monthabrev">
	    <xsl:with-param name="dt" select="$endsOn"/>
	  </xsl:call-template>
	</xsl:variable>
	<strong>End Date</strong>: <xsl:value-of select="$endsOnStr"/>
	<br/>

    <xsl:variable name="text">
      <xsl:call-template name="get-project-description">
		<xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
	<strong>Summary:</strong>
	<div>
	<xsl:value-of disable-output-escaping="yes" select="string($text)"/>
	</div>

    <div><table style="border-top-color:white;">
      <tbody style="border-top:0px solid white;">
      <tr style="border-top:0px solid white;">
        <th class="$thename" style="width:75%;border-top:0px solid white;"><xsl:value-of select="$title"/> Updates</th>
        <th class="$thename" style="width:25%;border-top:0px solid
        white;"><a href="{$project-url}">Click to add <xsl:value-of select="$title"/> Update</a></th>
      </tr>
      </tbody>
    </table></div>

    <xsl:choose>
      <xsl:when test="key('dco:ReportingYear-nodes', key('dco:ProjectUpdate-nodes',$node/dco:hasProjectUpdate/@rdf:resource|$node/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/@rdf:resource|key('dco:ProjectUpdate-nodes',$node/dco:hasProjectUpdate/@rdf:resource|$node/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/*/@rdf:about)">
        <xsl:for-each select="key('dco:ReportingYear-nodes', key('dco:ProjectUpdate-nodes',$node/dco:hasProjectUpdate/@rdf:resource|$node/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/@rdf:resource|key('dco:ProjectUpdate-nodes',$node/dco:hasProjectUpdate/@rdf:resource|$node/dco:hasProjectUpdate/*/@rdf:about)/dco:forReportingYear/*/@rdf:about)">
          <xsl:sort select="dco:startsOn"/>
          <xsl:call-template name="pu-list">
            <xsl:with-param name="admin" select="$admin"/>
            <xsl:with-param name="project" select="$node"/>
            <xsl:with-param name="ry" select="current()"/>
            <xsl:with-param name="root" select="$root"/>
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <p xmlns="http://www.w3.org/1999/xhtml">Currently No Project Updates</p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
