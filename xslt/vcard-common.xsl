<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY obo "http://purl.obolibrary.org/obo/">
  <!ENTITY vcard "http://www.w3.org/2006/vcard/ns#">
  
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:vivo="&vivo;"
		xmlns:foaf="&foaf;"
		xmlns:obo="&obo;"
		xmlns:vcard="&vcard;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:bibo="http://purl.org/ontology/bibo/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="vcard:vcard-nodes" match="vcard:Kind|*[rdf:type/@rdf:resource='&vcard;Kind']" use="@rdf:about"/>
  <xsl:key name="vcard:vcard-urls" match="vcard:URL|*[rdf:type/@rdf:resource='&vcard;URL']" use="@rdf:about"/>

  <xsl:template name="place-webpages">
    <xsl:param name="node"/>
      <xsl:choose>
        <xsl:when test="$node/obo:ARG_2000028">
          <xsl:variable name="vcarduri" select="$node/obo:ARG_2000028/@rdf:resource"/>
          <xsl:variable name="vcardobj" select="key('vcard:vcard-nodes',$vcarduri)"/>

          <p>Websites:</p>
          <xsl:for-each select="$vcardobj/vcard:hasURL">
            <xsl:sort select="vivo:rank"/>
            <xsl:variable name="urluri" select="current()/@rdf:resource"/>
            <xsl:variable name="urlobj" select="key('vcard:vcard-urls',current()/@rdf:resource)"/>
            <xsl:variable name="url" select="$urlobj/vcard:url"/>
            <xsl:variable name="label" select="$urlobj/rdfs:label"/>
            <p><a href="{$url}"><xsl:value-of select="$urlobj/rdfs:label"/></a></p>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <p> </p>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <xsl:template name="place-news">
    <xsl:param name="node"/>
      <xsl:choose>
        <xsl:when test="$node/dco:instrInitiativeNews">
          <xsl:variable name="vcarduri" select="$node/dco:instrInitiativeNews/@rdf:resource"/>
          <xsl:variable name="vcardobj" select="key('vcard:vcard-nodes',$vcarduri)"/>

          <p>News Articles:</p>
          <xsl:for-each select="$vcardobj/vcard:hasURL">
            <xsl:sort select="vivo:rank"/>
            <xsl:variable name="urluri" select="current()/@rdf:resource"/>
            <xsl:variable name="urlobj" select="key('vcard:vcard-urls',current()/@rdf:resource)"/>
            <xsl:variable name="url" select="$urlobj/vcard:url"/>
            <xsl:variable name="label" select="$urlobj/rdfs:label"/>
            <p><a href="{$url}"><xsl:value-of select="$urlobj/rdfs:label"/></a></p>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <p> </p>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

