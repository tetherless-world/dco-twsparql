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

  <xsl:import href="/xslt/ry-common.xsl"/>
  <xsl:import href="/xslt/pu-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>

  <xsl:template name="project-pu-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>

    <xsl:variable name="ry_uri">
      <xsl:value-of select="$node/@rdf:about"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$root//dco:ProjectUpdate/dco:forReportingYear/@rdf:resource|$root//*[rdf:type/@rdf:resource='&dco;ProjectUpdate']/dco:forReportingYear/@rdf:resource = $ry_uri">

        <xsl:variable name="label">
          <xsl:call-template name="get-ry-label">
            <xsl:with-param name="ry" select="$node"/>
          </xsl:call-template>
        </xsl:variable>
        <div class="dialog">
        <h3><span style="font-size:10pt;"><xsl:value-of select="$label"/></span><span style="font-size:5pt;">  Click to expand</span></h3>
        <div>
        <br/>
        <ul class="pu">

          <xsl:for-each select="$root//dco:ProjectUpdate[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;ProjectUpdate' and @rdf:about]">
            <xsl:sort select="dco:submittedOn"/>

            <xsl:variable name="pu_ry_uri">
              <xsl:value-of select="./dco:forReportingYear/@rdf:resource|./dco:forReportingYear/@rdf:resource"/>
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
                <h4>Update Details:</h4>
                <div>
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
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p> </p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
