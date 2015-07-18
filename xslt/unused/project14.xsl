<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:res="http://www.w3.org/2005/sparql-results#"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="res xsl">
<xsl:template match="/">
 <html>
  
  <div id="findings">
<h2>- - - - - - - - - - Three: an attempt to break the query results up in the tags needed- - - - - - - - - - - - -  - - - </h2>
   
      <xsl:for-each select="res:sparql/res:head/res:variable">
       <h3><xsl:value-of select="@name" /></h3>
      </xsl:for-each>
    <xsl:for-each select="res:sparql/res:results/res:result">
      <xsl:for-each select="res:binding">
        <div>
       	 <p><strong>Date</strong>: [date of project start] - [date of project end]<br />
     	 <strong>Project Members</strong>: [Name], [institution];<br /><strong>Summary</strong>: <xsl:value-of select="res:literal" /> [project detail page URL with Vivo query string, ie: http://dco.tw.rpi.edu/web/dco_project_summary?uri=http://deepcarbon.net/vivo/individual/n3053]</p>
        	</div>
      </xsl:for-each>
    </xsl:for-each>
  </div>
 </html>
</xsl:template> 
</xsl:stylesheet>