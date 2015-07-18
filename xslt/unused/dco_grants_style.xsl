<?xml version="1.0"?>

<!--

XSLT script to format SPARQL Query Results XML Format into xhtml

Copyright © 2004, 2005 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for
Informatics and Mathematics, Keio University). All Rights
Reserved. This work is distributed under the W3C® Software
License [1] in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231

Version 1 : Dave Beckett (DAWG)
Version 2 : Jeen Broekstra (DAWG)
Customization for SPARQler: Andy Seaborne
Customization for TWC: Patrick West
Fix:

> -    <xsl:for-each select="//res:head/res:variable">
> +    <xsl:for-each select="/res:sparql/res:head/res:variable">

-->

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

  <xsl:template name="header">
    <div>
      <h2>Header</h2>
      <xsl:for-each select="res:head/res:link"> 
	<p>Link to <xsl:value-of select="@href"/></p>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template name="boolean-result">
    <div>
      <!--      
	<h2>Boolean Result</h2>
      -->      
      <p>ASK => <xsl:value-of select="res:boolean"/></p>
    </div>
  </xsl:template>


  <xsl:template name="vb-result">
    <div>
      <!--
	<h2>Variable Bindings Result</h2>
	<p>Ordered: <xsl:value-of select="res:results/@ordered"/></p>
	<p>Distinct: <xsl:value-of select="res:results/@distinct"/></p>
      -->

	  <table>
	<xsl:text>
	</xsl:text>
	<tr>
	  <xsl:for-each select="res:head/res:variable">
        <xsl:variable name="thename" select="translate(@name,'_',' ')"/>
	    <th class="$thename"><xsl:value-of select="$thename"/></th>
	  </xsl:for-each>
	</tr>
	<xsl:text>
	</xsl:text>
	<xsl:for-each select="res:results/res:result">
	  <tr>
	    <xsl:apply-templates select="."/>
	  </tr>
	</xsl:for-each>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="res:result">
    <xsl:variable name="current" select="."/>
    <xsl:for-each select="/res:sparql/res:head/res:variable">
      <xsl:variable name="name" select="@name"/>
      <td class="{$name}">
	<xsl:choose>
	  <xsl:when test="$current/res:binding[@name=$name]">
	    <!-- apply template for the correct value type (bnode, uri, literal) -->
	    <xsl:apply-templates select="$current/res:binding[@name=$name]"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <!-- no binding available for this variable in this solution -->
	  </xsl:otherwise>
	</xsl:choose>
      </td>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="res:bnode">
    <xsl:text>_:</xsl:text>
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="res:uri">
    <xsl:variable name="uri" select="text()"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$uri"/>
    <xsl:text>&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="res:literal">
    <xsl:variable name="cell-value">
      <xsl:value-of select="text()"/>
    </xsl:variable>
    <xsl:choose>
	  <xsl:when test="starts-with($cell-value,'http:') or starts-with($cell-value,'https:')">
	  <a href="http://deepcarbon.net/dco_project_summary?uri={$cell-value}"><strong><xsl:value-of select="$cell-value"/></strong></a>
          <xsl:text>&#xa;</xsl:text>
	  </xsl:when>
      <xsl:otherwise>
	    <xsl:value-of select="$cell-value"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="@datatype">
	<!-- datatyped literal value -->
	^^&lt;<xsl:value-of select="@datatype"/>&gt;
      </xsl:when>
      <xsl:when test="@xml:lang">
	<!-- lang-string -->
	@<xsl:value-of select="@xml:lang"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="res:sparql">
	<xsl:if test="res:head/res:link">
	  <xsl:call-template name="header"/>
	</xsl:if>

	<xsl:choose>
	  <xsl:when test="res:boolean">
	    <xsl:call-template name="boolean-result" />
	  </xsl:when>

	  <xsl:when test="res:results">
	    <xsl:call-template name="vb-result" />
	  </xsl:when>

	</xsl:choose>
  </xsl:template>
</xsl:stylesheet>

