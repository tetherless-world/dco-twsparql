<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">

<xsl:template match="/">
 <html>
  <h2>Current Projects</h2>
  <div id="findings">
   <table border="1">
    <tr bgcolor="#9acd32">
      <xsl:for-each select="res:sparql/res:head/res:variable">
       <th><xsl:value-of select="@name" /></th>
      </xsl:for-each>
    </tr>
    <xsl:for-each select="res:sparql/res:results/res:result">
     <tr>
      <xsl:for-each select="res:binding">
       <td><xsl:value-of select="res:literal" /></td>
      </xsl:for-each>
     </tr>
    </xsl:for-each>
   </table>
  </div>
 </html>
</xsl:template> 
</xsl:stylesheet>
