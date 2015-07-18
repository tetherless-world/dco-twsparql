<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
<div class="findings" style="width:95%">
  <xsl:for-each select="res:sparql/res:results/res:result">
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Project'">
     <div class="proj_title" >
      <xsl:variable name="uri-value">
        <xsl:value-of select="following-sibling::res:binding/res:literal"/>
      </xsl:variable>
     <a href="http://deepcarbon.net/dco_project_summary?uri={$uri-value}"><xsl:value-of select="res:literal"/></a><xsl:comment> EOD proj_title </xsl:comment></div>
    </xsl:if>
   </xsl:for-each>
   <div class="proj_details">
   <xsl:for-each select="res:binding"> 
     <xsl:if test="@name='Start_Date' or @name='End_Date'">
      <div class="proj_item" >
      <strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="substring-before(res:literal,'T')"/><xsl:comment> EOD proj_item </xsl:comment></div>   
     </xsl:if>
     <xsl:if test="@name='Project_Investigators'">
      <div class="proj_item" >
      <strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="res:literal"/><xsl:comment> EOD proj_item </xsl:comment></div>
     </xsl:if>
     <xsl:if test="@name!='Project' and @name!='Start_Date' and @name!='End_Date' and @name!='Project_URI' and @name!='Project_Investigators' and @name!='Project_URI'">
      <div class="proj_item" >
      <strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>: </xsl:text></strong>
      <xsl:value-of select="res:literal" disable-output-escaping="yes"/><xsl:comment> EOD proj_item </xsl:comment></div>
     </xsl:if>
  </xsl:for-each>
  <xsl:comment> EOD proj_details </xsl:comment>
  </div>
 </xsl:for-each>
<xsl:comment> EOD proj_findings </xsl:comment>
</div>
</xsl:template>

</xsl:stylesheet>

