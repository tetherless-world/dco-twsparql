<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY dcodata "http://info.deepcarbon.net/data/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY dcat "http://www.w3.org/ns/dcat#">
  <!ENTITY skos "http://www.w3.org/2004/02/skos/core#">
  <!ENTITY prov "http://www.w3.org/ns/prov#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dct="http://purl.org/dc/terms/"
   xmlns:dco="&dco;"
   xmlns:dcodata="&dcodata;"
   xmlns:vivo="&vivo;"
   xmlns:dcat="&dcat;"
   xmlns:skos="&skos;"
   xmlns:prov="&prov;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/dataset-common.xsl"/>
  <xsl:import href="/xslt/team-common.xsl"/>
  <xsl:import href="/xslt/community-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/dcoid-common.xsl"/>
  <xsl:import href="/xslt/prov-common.xsl"/>
  <xsl:import href="/xslt/dtype-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>

  <xsl:template name="dataset">
    <xsl:param name="admin"/>
    <xsl:param name="root"/>

    <xsl:choose>
      <xsl:when test="$root//dcodata:Dataset[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dcodata;Dataset' and @rdf:about]">
        <xsl:variable name="dataset" select="$root//dcodata:Dataset[@rdf:about]|$root//*[rdf:type/@rdf:resource='&dcodata;Dataset' and @rdf:about]"/>

        <xsl:call-template name="place-dataset-label">
          <xsl:with-param name="dataset" select="$dataset"/>
          <xsl:with-param name="style" select='"font-weight:bold;font-size:140%;"'/>
        </xsl:call-template>

        <xsl:choose>
          <xsl:when test="$dataset/dct:issued">
            <xsl:variable name="yr">
              <xsl:call-template name="get-year-raw">
                <xsl:with-param name="dt" select="$dataset/dct:issued"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$yr"/>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>

        <br/><br/>

        <xsl:choose>
          <xsl:when test="$dataset/dct:description">
            <div style="font-size:120%;">
              <xsl:value-of select="$dataset/dct:description"/>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:call-template name="place-creators">
          <xsl:with-param name="dataset" select="$dataset"/>
        </xsl:call-template>

        <xsl:call-template name="place-contributors">
          <xsl:with-param name="dataset" select="$dataset"/>
        </xsl:call-template>


        <br/>
        <span style="font-weight:bold;font-size:120%;">Citation </span>
        <br/>
        <xsl:call-template name="place-dataset-authors">
          <xsl:with-param name="dataset" select="$dataset"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="$dataset/dct:issued">
            <xsl:variable name="yr">
              <xsl:call-template name="get-year-raw">
                <xsl:with-param name="dt" select="$dataset/dct:issued"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$yr"/>
            <xsl:text>): </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$dataset/dct:publisher">
            <xsl:for-each select="key('foaf:Agent-nodes',$dataset/dco:publisher/@rdf:resource)">
              <xsl:value-of select="current()/rdfs:label"/>
              <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
            <xsl:text>.</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$dataset/rdfs:label"/><xsl:text>. </xsl:text>
        <xsl:choose>
          <xsl:when test="$dataset/dct:identifier">
            <xsl:variable name="ident">
              <xsl:value-of select="$dataset/dct:identifier"/>
            </xsl:variable>
            <a href="http://dx.doi.org/{$ident}">$ident</a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="place-metadata-link">
              <xsl:with-param name="object" select="$dataset"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>

        <br/>
        <xsl:choose>
          <xsl:when test="$dataset/dco:associatedDCOCommunity">
            <br/>
            <span style="font-weight:bold;font-size:120%;">DCO Communities</span>
            <ul>
            <xsl:for-each select="key('dco:Community-nodes',$dataset/dco:associatedDCOCommunity/@rdf:resource)">
              <li>
              <xsl:value-of select="current()/rdfs:label"/>
              </li>
            </xsl:for-each>
            </ul>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
    
        <xsl:choose>
          <xsl:when test="$dataset/dco:associatedDCOTeam">
            <br/>
            <span style="font-weight:bold;font-size:120%;">DCO Teams</span>
            <ul>
            <xsl:for-each select="key('dco:Team-nodes',$dataset/dco:associatedDCOTeam/@rdf:resource)">
              <li>
              <xsl:value-of select="current()/rdfs:label"/>
              </li>
            </xsl:for-each>
            </ul>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="$dataset/dcat:theme">
            <br/>
            <span style="font-weight:bold;font-size:120%;">Subject Areas</span>
            <br/>
            <div>
              <xsl:for-each select="key('skos:Concept-nodes',$dataset/dcat:theme/@rdf:resource)">
                <xsl:call-template name="place-concept-profile-link">
                  <xsl:with-param name="concept" select="current()"/>
                </xsl:call-template>
                <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="$dataset/dco:hasDataType">
            <br/>
            <span style="font-weight:bold;font-size:120%;">Datatypes</span>
            <br/>
            <div>
              <xsl:for-each select="key('dco:DataType-nodes',$dataset/dco:hasDataType/@rdf:resource)">
                <xsl:call-template name="place-dtype-link">
                  <xsl:with-param name="dtype" select="current()"/>
                </xsl:call-template>
                <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="$dataset/prov:wasQuotedFrom">
            <br/>
            <span style="font-weight:bold;font-size:120%;">Rescued From</span>
            <br/>
            <div>
              <xsl:for-each select="key('prov:Entity-nodes',$dataset/prov:wasQuotedFrom/@rdf:resource)">
                <xsl:call-template name="place-entity-link">
                  <xsl:with-param name="entity" select="current()"/>
                </xsl:call-template>
                <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="$dataset/dcat:distribution">
            <br/>
            <span style="font-weight:bold;font-size:120%;">Distributions</span>
            <br/>
            <xsl:for-each select="key('dcodata:Distribution-nodes',$dataset/dcat:distribution/@rdf:resource)">
              <div style="border-top:2px solid black;width:100%">
                <span style="font-weight:bold;">distribution: </span>
                <xsl:call-template name="place-distribution-link">
                  <xsl:with-param name="distribution" select="current()"/>
                  <xsl:with-param name="style" select='""'/>
                </xsl:call-template>
		<br/>

                <xsl:choose>
                  <xsl:when test="current()/dcat:accessURL">
                    Access URL(s)
                    <ul>
                      <xsl:for-each select="current()/dcat:accessURL">
                        <xsl:variable name="access" select="current()/@rdf:resource"/>
                        <li><a href="{$access}"><xsl:value-of select="$access"/></a></li>
                      </xsl:for-each>
                    </ul>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text> </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>

                <xsl:choose>
                  <xsl:when test="current()/dcat:downloadURL">
                    Download URL(s)
                    <ul>
                      <xsl:for-each select="current()/dcat:downloadURL">
                        <xsl:variable name="download" select="current()/@rdf:resource"/>
                        <li><a href="{$download}"><xsl:value-of select="$download"/></a></li>
                      </xsl:for-each>
                    </ul>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text> </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
              <xsl:if test="position() = last()">
                <div style="border-top:2px solid black;width:100%">

                </div>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <br/>
        <span style="font-weight:bold;">metadata: </span>
        <xsl:call-template name="place-metadata-link">
          <xsl:with-param name="object" select="$dataset"/>
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        The requested Dataset does not exist
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="dataset">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="root" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
