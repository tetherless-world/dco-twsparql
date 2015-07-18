<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
 <div style="width:95%">
 <xsl:for-each select="res:sparql/res:results/res:result">
   <div>
   <xsl:for-each select="res:binding"> 
     <xsl:if test="@name='DCO_ID'">
      <xsl:text>Deep Carbon Observatory Data Portal. </xsl:text> <xsl:text>Data set accessed on (date) at </xsl:text>
      <xsl:variable name="uri-value">
        <xsl:value-of select="res:literal"/>
      </xsl:variable>
     <a href="{$uri-value}"><xsl:value-of select="res:literal"/></a>
    </xsl:if>
     <xsl:if test="@name='Date'">
      <xsl:value-of select="substring(res:literal, 1, 4)"/><xsl:text>. </xsl:text>
     </xsl:if>
     <xsl:if test="@name='Year'">
      <xsl:value-of select="substring(res:literal, 1, 4)"/><xsl:text>. </xsl:text>
     </xsl:if>
     <xsl:if test="@name='ModDate'">
      <xsl:text>Updated </xsl:text><xsl:value-of select="substring(res:literal, 1, 10)"/><xsl:text>. </xsl:text>
     </xsl:if>
     <xsl:if test="@name='Authors'"> <b><xsl:text>Suggested citation: </xsl:text></b>
     <xsl:value-of select="res:literal" disable-output-escaping="yes"/><xsl:text>. </xsl:text>
     </xsl:if>
     <xsl:if test="@name='Title'">
     <xsl:value-of select="res:literal" disable-output-escaping="yes"/><xsl:text>. </xsl:text>
     </xsl:if>
  </xsl:for-each>
  </div>
 </xsl:for-each>
</div>
</xsl:template>

</xsl:stylesheet>

