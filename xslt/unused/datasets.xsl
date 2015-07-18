<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
 <div id="datasets" style="width:95%">
 <xsl:for-each select="res:sparql/res:results/res:result">
   <xsl:for-each select="res:binding"> 
    <xsl:if test="@name='Title'"><hr class="hrsummary" />
     <h3 style="font-size: 135%; margin-top: 0em; margin-bottom: 12px;padding-top: 3px">
      <xsl:variable name="uri-value">
        <xsl:value-of select="following-sibling::res:binding/res:uri"/>
      </xsl:variable>
     <a href="http://deepcarbon.net/dco_dataset_summary?uri={$uri-value}"><xsl:value-of select="res:literal"/></a></h3>
    </xsl:if>
  </xsl:for-each>
   <div>
   <xsl:for-each select="res:binding"> 
    <p style="margin-top: 0em; margin-bottom: 0em;">
     <xsl:if test="@name='DCO_ID'">
      <span style="color: #a6aaad; font-size: 80%; text-transform: uppercase"><strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>	</xsl:text></strong></span><br />
      <xsl:value-of select="res:literal"/>
     </xsl:if>
     <xsl:if test="@name='DCO_Community'">
      <br /><span style="color: #a6aaad; font-size: 80%; text-transform: uppercase"><strong><xsl:value-of select="translate(@name,'_',' ')"/><xsl:text>	</xsl:text></strong></span><br />
      <xsl:value-of select="res:literal"/>
     </xsl:if>
     <xsl:if test="@name!='Title' and @name!='dataset' and @name!='DCO_ID' and @name!='DCO_Community' and @name!='dataset2'">
      <br /><span style="color: #a6aaad; font-size: 80%; text-transform: uppercase"><strong><xsl:value-of select="@name"/><xsl:text>	</xsl:text></strong></span><br />
      <xsl:value-of select="res:literal" disable-output-escaping="yes"/><br />
     </xsl:if>
     <xsl:if test="@name='dataset2'">
      <xsl:variable name="uri-value">
        <xsl:value-of select="res:literal"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="starts-with($uri-value,'http:') or starts-with($uri-value,'https:')">
	  <a href="http://deepcarbon.net/dco_dataset_summary?uri={$uri-value}"><strong><xsl:text>Details...</xsl:text></strong></a><br />
	</xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
     </xsl:choose>     
     </xsl:if>
    </p>
  </xsl:for-each><br />
  </div>
 </xsl:for-each>
</div>
</xsl:template>

</xsl:stylesheet>

