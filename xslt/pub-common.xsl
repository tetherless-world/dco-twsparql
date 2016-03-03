<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY obo "http://purl.obolibrary.org/obo/">
  <!ENTITY bibo "http://purl.org/ontology/bibo/">
  
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:vivo="&vivo;"
		xmlns:foaf="&foaf;"
		xmlns:obo="&obo;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:bibo="&bibo;"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:key name="bibo:Document-nodes" match="bibo:Document|*[rdf:type/@rdf:resource='&bibo;Document']" use="@rdf:about"/>
  <xsl:key name="vivo:Authorship-nodes" match="vivo:Authorship|*[rdf:type/@rdf:resource='&vivo;Authorship']" use="@rdf:about"/>
  <xsl:key name="bibo:Journal-nodes" match="bibo:Journal|*[rdf:type/@rdf:resource='&bibo;Journal']" use="@rdf:about"/>

  <xsl:template name="place-journal">
    <xsl:param name="doc"/>
    <xsl:variable name="journal" select="key('bibo:Journal-nodes',$doc/vivo:hasPublicationVenue/@rdf:resource)"/>
    <xsl:text> </xsl:text><xsl:value-of select="$journal/rdfs:label"/>
    <xsl:if test="$doc/bibo:volume">
      <xsl:text> </xsl:text><xsl:value-of select="$doc/bibo:volume"/>
      <xsl:if test="$doc/bibo:issue">
        <xsl:text>(</xsl:text><xsl:value-of select="$doc/bibo:issue"/><xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$doc/bibo:pageStart">
      <xsl:text>:</xsl:text><xsl:value-of select="$doc/bibo:pageStart"/>
      <xsl:if test="$doc/bibo:pageEnd">
        <xsl:text>-</xsl:text><xsl:value-of select="$doc/bibo:pageEnd"/>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="place-author">
    <xsl:param name="author"/>
    <xsl:variable name="person" select="key('foaf:Person-nodes',$author/vivo:relates/@rdf:resource)"/>
    <xsl:variable name="person_url" select="$person/@rdf:about"/>
    <!--<a href="{$person_url}"><xsl:value-of select="$person/rdfs:label"/></a>-->

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

  <xsl:template name="place-authors">
    <xsl:param name="doc"/>
    <xsl:for-each select="key('vivo:Authorship-nodes',$doc/vivo:relatedBy/@rdf:resource)">
      <xsl:sort select="vivo:rank"/>
      <xsl:call-template name="place-author">
        <xsl:with-param name="author" select="current()"/>
      </xsl:call-template>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>. </xsl:text>
  </xsl:template>

  <xsl:template name="place-citation">
    <xsl:param name="doc"/>

    <h3 style="margin-top: 0em; margin-bottom: 0em;">
    <xsl:choose>
      <xsl:when test="$doc/bibo:doi">
        <xsl:variable name="doi" select="$doc/bibo:doi"/>
        <a href="https://dx.doi.org/{$doi}"><xsl:value-of select="$doc/rdfs:label"/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="docuri" select="$doc/@rdf:about"/>
        <a href="{$docuri}"><xsl:value-of select="$doc/rdfs:label"/></a>
      </xsl:otherwise>
    </xsl:choose>
    </h3>

    <div>
    <xsl:call-template name="place-authors">
      <xsl:with-param name="doc" select="$doc"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>

    <xsl:if test="$doc/dco:yearOfPublication">
      <xsl:text>(</xsl:text><xsl:value-of select="$doc/dco:yearOfPublication"/><xsl:text>) </xsl:text>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$doc/bibo:doi">
        <xsl:variable name="doi" select="$doc/bibo:doi"/>
        <a href="https://dx.doi.org/{$doi}"><xsl:value-of select="$doc/rdfs:label"/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="docuri" select="$doc/@rdf:about"/>
        <a href="{$docuri}"><xsl:value-of select="$doc/rdfs:label"/></a>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.</xsl:text>

    <xsl:if test="$doc/vivo:hasPublicationVenue">
      <xsl:call-template name="place-journal">
        <xsl:with-param name="doc" select="$doc"/>
      </xsl:call-template>
    </xsl:if>
    </div>

  </xsl:template>

  <xsl:template name="place-dco-citations">
    <xsl:param name="node"/>
      <xsl:choose>
        <xsl:when test="$node/dco:associatedPublication">
          <p style="font-weight:bold;">Publications:</p>
          <div id="findings" style="width:95%">
          <xsl:for-each select="key('bibo:Document-nodes',$node/dco:associatedPublication/@rdf:resource)">
            <xsl:sort select="rdfs:label"/>
            <xsl:call-template name="place-citation">
              <xsl:with-param name="doc" select="current()"/>
            </xsl:call-template>
          </xsl:for-each>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <p> </p>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

