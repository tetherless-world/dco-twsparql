<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
 <div id="findings" style="width:95%">
 <xsl:for-each select="res:sparql/res:results/res:result">
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Project'">
     <h3 style="margin-top: 0em; margin-bottom: 0em;">
      <xsl:variable name="uri-value">
        <xsl:value-of select="following-sibling::res:binding/res:literal"/>
      </xsl:variable>
     <a href="http://deepcarbon.net/dco_project_summary?uri={$uri-value}"><xsl:value-of select="res:literal"/></a></h3>
    </xsl:if>
  </xsl:for-each>
   <div>
   <xsl:for-each select="res:binding"> 
    <p style="margin-top: 0em; margin-bottom: 0em;">
     <xsl:if test="@name='Start_Date' or @name='End_Date'">
      <strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="substring-before(res:literal,'T')"/>
     </xsl:if>
     <xsl:if test="@name='Project_Investigators'">
      <strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="res:literal"/>
     </xsl:if>
     <xsl:if test="@name!='Project' and @name!='Start_Date' and @name!='End_Date' and @name!='Project_URI' and @name!='Project_Investigators'">
      <strong><xsl:value-of select="@name"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="res:literal" disable-output-escaping="yes"/>
     </xsl:if>
     <xsl:if test="@name='Project_URI'">
      <xsl:variable name="uri-value">
        <xsl:value-of select="res:literal"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="starts-with($uri-value,'http:') or starts-with($uri-value,'https:')">
	  <a href="http://deepcarbon.net/dco_project_summary?uri={$uri-value}"><strong><xsl:text>Details...</xsl:text></strong></a>
	</xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
     </xsl:choose>     
     </xsl:if>
    </p>
  </xsl:for-each>
  </div>
 </xsl:for-each>
</div>
</xsl:template>

</xsl:stylesheet>

