<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
 
 <xsl:template match="/">
   <div>I found a &lt;sparql&gt; tag!</div>
 </xsl:template>
 
 <xsl:template match="/">
   <xsl:apply-templates select="sparql"/>
 </xsl:template>
 
</xsl:stylesheet>