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

  <xsl:import href="/xslt/project-pu-list-item.xsl"/>
  <xsl:import href="/xslt/pu-common.xsl"/>

  <xsl:template name="ry-list">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>

    <xsl:variable name="project-url">
      <xsl:call-template name="get-pu-project-url">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:variable>

    <div><table>
      <tr>
        <th class="$thename" style="width:70%;">Project Updates</th>
        <th class="$thename" style="width:30%;"><a
        href="{$project-url}">Click to add Project Update</a></th>
      </tr>
      <tr><td>
        <xsl:for-each select="$node//dco:ReportingYear[@rdf:about]|$node//*[rdf:type/@rdf:resource='&dco;ReportingYear' and @rdf:about]">
          <xsl:sort select="dco:startsOn"/>
          <xsl:call-template name="project-pu-list-item">
            <xsl:with-param name="admin" select="$admin"/>
            <xsl:with-param name="node" select="current()"/>
          </xsl:call-template>
        </xsl:for-each>
      </td></tr>
    </table></div>

  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="ry-list">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="node" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
