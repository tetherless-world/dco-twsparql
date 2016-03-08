<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
 <div id="sibings" style="width:95%">
 <ul>
<xsl:for-each select="res:sparql/res:results/res:result[1]">
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Community'">
      <li><strong>
        <xsl:value-of select="res:literal"/><xsl:text> Projects</xsl:text>
      </strong></li>
    </xsl:if>
  </xsl:for-each>
</xsl:for-each>

 <xsl:for-each select="res:sparql/res:results/res:result">
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Project'">
     <li><strong>
      <xsl:variable name="uri-value">
        <xsl:value-of select="following-sibling::res:binding/res:literal"/>
      </xsl:variable>
     <a href="/dco_project_summary?uri={$uri-value}"><xsl:value-of select="res:literal"/></a></strong></li>
    </xsl:if>
  </xsl:for-each>
 </xsl:for-each>
</ul>
</div>
</xsl:template>

</xsl:stylesheet>

