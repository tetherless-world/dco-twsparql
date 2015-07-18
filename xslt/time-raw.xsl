<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY time "http://www.w3.org/2006/time#">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:template name="name-of-month">
    <xsl:param name="month"/>
    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>January</xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>February</xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>March</xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>April</xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>May</xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>June</xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>July</xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>August</xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>September</xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>October</xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>November</xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>December</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="name-of-month-raw">
    <xsl:param name="dt"/>
    <xsl:call-template name="name-of-month">
      <xsl:with-param name="month" select="substring($dt,6,2)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="abrev-of-month-raw">
    <xsl:param name="dt"/>
    <xsl:variable name="full">
      <xsl:call-template name="name-of-month-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="substring($full,1,3)"/>
  </xsl:template>

  <xsl:template name="get-year-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,1,4)"/>
  </xsl:template>

  <xsl:template name="get-month-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,6,2)"/>
  </xsl:template>

  <xsl:template name="get-day-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,9,2)"/>
  </xsl:template>

  <xsl:template name="get-time-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,12,8)"/>
  </xsl:template>

  <xsl:template name="get-hour-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,12,2)"/>
  </xsl:template>

  <xsl:template name="get-min-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,15,2)"/>
  </xsl:template>

  <xsl:template name="get-sec-raw">
    <xsl:param name="dt"/>
    <xsl:value-of select="substring($dt,18,2)"/>
  </xsl:template>

  <xsl:template name="get-date-monthlong">
    <xsl:param name="dt"/>
    <xsl:variable name="year">
      <xsl:call-template name="get-year-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="month">
      <xsl:call-template name="name-of-month-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="day">
      <xsl:call-template name="get-day-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$month"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$day"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$year"/>
  </xsl:template>

  <xsl:template name="get-date-monthabrev">
    <xsl:param name="dt"/>
    <xsl:variable name="year">
      <xsl:call-template name="get-year-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="month">
      <xsl:call-template name="abrev-of-month-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="day">
      <xsl:call-template name="get-day-raw">
        <xsl:with-param name="dt" select="$dt"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$month"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$day"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$year"/>
  </xsl:template>

  <xsl:template name="get-date-timeplain-monthlong">
    <xsl:param name="dt"/>
    <xsl:call-template name="get-date-monthlong">
      <xsl:with-param name="dt" select="$dt"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="get-time-raw">
      <xsl:with-param name="dt" select="$dt"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="get-date-timeplain-monthabrev">
    <xsl:param name="dt"/>
    <xsl:call-template name="get-date-monthabrev">
      <xsl:with-param name="dt" select="$dt"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="get-time-raw">
      <xsl:with-param name="dt" select="$dt"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>

