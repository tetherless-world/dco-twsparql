<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY dco "http://info.deepcarbon.net/schema#">
  <!ENTITY vivo "http://vivoweb.org/ontology/core#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY ero "http://purl.obolibrary.org/obo/">
  <!ENTITY vp "http://vitro.mannlib.cornell.edu/ns/vitro/public#">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:dco="&dco;"
		xmlns:vivo="&vivo;"
		xmlns:foaf="&foaf;"
		xmlns:ero="&ero;"
		xmlns:vp="&vp;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:bibo="http://purl.org/ontology/bibo/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="vp:File-nodes" match="vp:File|*[rdf:type/@rdf:resource='&vp;File']" use="@rdf:about"/>
  <xsl:key name="vp:File-stream" match="vp:FileByteStream|*[rdf:type/@rdf:resource='&vp;FileByteStream']" use="@rdf:about"/>

  <xsl:template name="place-image">
    <xsl:param name="node"/>
    <xsl:param name="style"/>

    <xsl:choose>
      <xsl:when test="$node/vp:mainImage">
        <xsl:variable name="imageuri" select="$node/vp:mainImage/@rdf:resource"/>
        <xsl:variable name="imageobj" select="key('vp:File-nodes',$imageuri)"/>

        <xsl:variable name="fileuri" select="$imageobj/vp:downloadLocation/@rdf:resource"/>
        <xsl:variable name="fileobj" select="key('vp:File-stream',$fileuri)"/>
        <xsl:variable name="fileloc" select="$fileobj/vp:directDownloadUrl"/>

        <a href="http://info.deepcarbon.net/vivo{$fileloc}"><img class="framer" src="https://info.deepcarbon.net/vivo{$fileloc}" style="{$style}"/></a>
      </xsl:when>
      <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

