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
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/grant-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/ry-common.xsl"/>

  <xsl:template name="grant-summary">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>

    <xsl:choose>
      <xsl:when test="$root//dco:ReportingYear|$root//*/rdf:type[@rdf:resource='&dco;ReportingYear']">
        <h3 class="section">Grant Summary for 
        <xsl:call-template name="get-ry-label">
          <xsl:with-param name="ry" select="$root//dco:ReportingYear[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dco;ReportingYear' and @rdf:about]"/>
        </xsl:call-template>
        </h3>
      </xsl:when>
      <xsl:otherwise>
        <h3 class="section">Grant Summary for All Reporting Years</h3>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:variable name="grant" select="$root//vivo:Grant[@rdf:about]|$root//*[rdf:type/@rdf:resource='&vivo;Grant' and @rdf:about]"/>

    <div>
    <table>
      <tr>
        <th class="Grant">Grant</th>
        <th class="Total_Award">Total Award</th>
        <th style="Recipient">Recipient</th>
      </tr>
      <tr>
        <td class="Grant">
          <xsl:call-template name="get-grant-label">
            <xsl:with-param name="grant" select="$grant"/>
          </xsl:call-template>
        </td>
        <td class="Total_Award">
          <xsl:call-template name="get-grant-award">
            <xsl:with-param name="grant" select="$grant"/>
          </xsl:call-template>
        </td>
        <td class="Recipient">
          <xsl:choose>
            <xsl:when test="$grant/dco:grantRecipient">
              <xsl:call-template name="place-grant-recipient">
                <xsl:with-param name="grant" select="$grant"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text></xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
    </div>
  <br/>
  <div class="Abstract" style="font-weight:bold;">Abstract</div>
  <div>
  <xsl:call-template name="get-grant-abstract">
    <xsl:with-param name="grant" select="$grant"/>
  </xsl:call-template>
  </div>

  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="grant-summary">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
