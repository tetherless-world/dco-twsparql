<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY time "http://www.w3.org/2006/time#">
  <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:template name="day-of-month">
    <xsl:param name="day"/>
    <xsl:choose>
       <xsl:when test="substring($day,1,1)='0'">
	 <xsl:value-of select="substring($day,2,1)"/>
       </xsl:when>
       <xsl:otherwise>
	 <xsl:value-of select="$day"/>
       </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="name-of-month">
    <xsl:param name="month"/>
    <xsl:param name="style">normal</xsl:param>
    <xsl:choose>
      <xsl:when test="$style='short'">
	<xsl:choose>
	  <xsl:when test="$month='01'">
            <xsl:text>Jan</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='02'">
            <xsl:text>Feb</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='03'">
            <xsl:text>Mar</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='04'">
            <xsl:text>Apr</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='05'">
            <xsl:text>May</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='06'">
            <xsl:text>Jun</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='07'">
            <xsl:text>Jul</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='08'">
            <xsl:text>Aug</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='09'">
            <xsl:text>Sep</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='10'">
            <xsl:text>Oct</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='11'">
            <xsl:text>Nov</xsl:text>
	  </xsl:when>
	  <xsl:when test="$month='12'">
            <xsl:text>Dec</xsl:text>
	  </xsl:when>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
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
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']"
                mode="year">
    <span typeof="time:Instant">
      <span property="time:inXSDDateTime"
            datatype="xsd:dateTime"
            content="{time:inXSDDateTime}">
        <xsl:value-of select="substring(time:inXSDDateTime,1,4)"/>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']"
                mode="date">
    <span typeof="time:Instant">
      <span property="time:inXSDDateTime"
            datatype="xsd:dateTime"
            content="{time:inXSDDateTime}">
        <xsl:call-template name="name-of-month">
          <xsl:with-param name="month" select="substring(time:inXSDDateTime,6,2)"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="day-of-month">
	  <xsl:with-param name="day" select="substring(time:inXSDDateTime,9,2)"/>
	</xsl:call-template>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="substring(time:inXSDDateTime,1,4)"/>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="dc:modified[@rdf:datatype='&xsd;dateTime']">
    <span property="dc:modified" content="{.}">
      <xsl:call-template name="name-of-month">
        <xsl:with-param name="month" select="substring(.,6,2)"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:call-template name="day-of-month">
	<xsl:with-param name="day" select="substring(.,9,2)"/>
      </xsl:call-template>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="substring(.,1,4)"/>
      <br/>
      <xsl:value-of select="substring(.,12,8)"/>
    </span>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']"
                mode="hidden">
    <span typeof="time:Instant">
      <span property="time:inXSDDateTime"
            datatype="xsd:dateTime"
            content="{time:inXSDDateTime}">
      </span>
    </span>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']">
    <span typeof="time:Instant">
      <span property="time:inXSDDateTime"
            datatype="xsd:dateTime"
            content="{time:inXSDDateTime}">
        <xsl:value-of select="time:inXSDDateTime"/>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']" mode="segment">
    <time:date>
      <time:year><xsl:value-of select="substring(time:inXSDDateTime,1,4)"/></time:year>
      <time:month><xsl:value-of select="substring(time:inXSDDateTime,6,2)"/></time:month>
      <time:day><xsl:value-of select="substring(time:inXSDDateTime,9,2)"/></time:day>
      <time:hour><xsl:value-of select="substring(time:inXSDDateTime,12,2)"/></time:hour>
      <time:minute><xsl:value-of select="substring(time:inXSDDateTime,15,2)"/></time:minute>
      <time:second><xsl:value-of select="substring(time:inXSDDateTime,18,2)"/></time:second>
    </time:date>
  </xsl:template>

  <xsl:template match="time:Interval|*[rdf:type/@rdf:resource='&time;Interval']" mode="date-range">
    <xsl:variable name="start-date-raw">
      <xsl:apply-templates select="time:hasBeginning/*" mode="segment"/>
    </xsl:variable>
    <xsl:variable name="start-date" select="exsl:node-set($start-date-raw)"/>
    <span typeof="time:Interval">
      <span rel="time:hasBeginning">
	<span typeof="time:Instant">
	  <span property="time:inXSDDateTime" content="{time:hasBeginning/*/time:inXSDDateTime}">
	    <xsl:call-template name="name-of-month">
	      <xsl:with-param name="month" select="$start-date/time:date/time:month"/>
	    </xsl:call-template>
	    <xsl:text> </xsl:text>
	    <xsl:call-template name="day-of-month">
	      <xsl:with-param name="day" select="$start-date/time:date/time:day"/>
	    </xsl:call-template>
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="time:hasEnd">
	<xsl:variable name="end-date-raw">
	  <xsl:apply-templates select="time:hasEnd/*" mode="segment"/>
	</xsl:variable>
	<xsl:variable name="end-date" select="exsl:node-set($end-date-raw)"/>
	<xsl:if test="$start-date/time:date/time:year!=$end-date/time:date/time:year">
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="$start-date/time:date/time:year"/>
	</xsl:if>
	<xsl:if test="not($start-date/time:date/time:year = $end-date/time:date/time:year and $start-date/time:date/time:month = $end-date/time:date/time:month and $start-date/time:date/time:day = $end-date/time:date/time:day)">
	  <xsl:text>-</xsl:text>
	</xsl:if>
	<span rel="time:hasEnd">
	  <span typeof="time:Instant">
	    <span property="time:inXSDDateTime" content="{time:hasEnd/*/time:inXSDDateTime}">
	      <xsl:if test="$start-date/time:date/time:year/text()!=$end-date/time:date/time:year/text() or $start-date/time:date/time:month/text()!=$end-date/time:date/time:month/text()">
		<xsl:call-template name="name-of-month">
		  <xsl:with-param name="month" select="$end-date/time:date/time:month"/>
		</xsl:call-template>
		<xsl:text> </xsl:text>
	      </xsl:if>
	      <xsl:if test="$start-date/time:date/time:year/text()!=$end-date/time:date/time:year/text() or $start-date/time:date/time:month/text()!=$end-date/time:date/time:month/text() or $start-date/time:date/time:day/text()!=$end-date/time:date/time:day/text()">
		<xsl:call-template name="day-of-month">
		  <xsl:with-param name="day" select="$end-date/time:date/time:day"/>
		</xsl:call-template>
	      </xsl:if>
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="$end-date/time:date/time:year"/>
	    </span>
	  </span>
	</span>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="$start-date/time:date/time:year"/>
	</xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>
</xsl:stylesheet>
