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
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Article'">
      <xsl:variable name="doi-value-1">
        <xsl:value-of select="following-sibling::res:binding/res:literal"/>
      </xsl:variable>
      <a href="http://dx.doi.org/{$doi-value-1}"><xsl:value-of select="res:literal" disable-output-escaping="yes"/></a>
    </xsl:if>
  </xsl:for-each>
   <div>
   <xsl:for-each select="res:binding"> 
     <xsl:if test="@name='DOI2'">
      <xsl:variable name="doi-value-2"> <xsl:value-of select="res:literal" disable-output-escaping="yes"/> </xsl:variable>
      <a href="http://dx.doi.org/{$doi-value-2}"><xsl:text>DOI:</xsl:text><xsl:value-of select="res:literal" disable-output-escaping="yes"/></a>
     </xsl:if>
     <xsl:if test="@name='Year'">
      <xsl:text>(</xsl:text><xsl:value-of select="res:literal" disable-output-escaping="yes"/><xsl:text>). </xsl:text>
     </xsl:if>
     <xsl:if test="@name='Authors'">
      <strong><xsl:value-of select="res:literal" disable-output-escaping="yes"/></strong><xsl:text> </xsl:text>
     </xsl:if>
     <xsl:if test="@name!='ArticleID' and @name!='Article' and @name!='Year' and @name!='Authors' and @name!='DOI1' and @name!='DOI2'">
      <xsl:value-of select="res:literal" disable-output-escaping="yes"/>,<xsl:text> </xsl:text>
     </xsl:if>
  </xsl:for-each><br /><hr class="hrsummary" /></div>
 </xsl:for-each>
</div>
</xsl:template>

</xsl:stylesheet>

