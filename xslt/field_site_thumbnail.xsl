<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
<div style="text-align:left">
 <xsl:for-each select="res:sparql/res:results/res:result">
   <div>
   <xsl:for-each select="res:binding"> 
     <xsl:if test="@name='thumbNailLocation'">
      <xsl:variable name="uri-value">
        <xsl:value-of select="res:uri"/>
      </xsl:variable>
     <img src="{$uri-value}" height="200"></img>
    </xsl:if>
  </xsl:for-each>
  </div>
 </xsl:for-each>
</div>
</xsl:template>

</xsl:stylesheet>

