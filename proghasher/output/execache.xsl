<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="maintype"/>
  <xsl:param name="mainnumber"/>
  <xsl:param name="start"/>

  <xsl:output method="html"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="Storage">
    <xsl:variable name="length" select="count(//FoundList[@type = $maintype]//Item)"/>
    <div style="display:block">
      <span id="size">
        <xsl:value-of select="$maintype"/>
      </span>
	  <xsl:value-of select="//FoundList[@type = $maintype]"/>
    </div>
    <xsl:if test="$length &gt; 0">
      <xsl:apply-templates/>
    </xsl:if>
    <xsl:if test="$length = 0">
      <div style="display:visible">
        <span id="size" align="center">
          No Records found!
        </span>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ProgHasher">
    <!--xsl:apply-templates select="FoundList[@type = $maintype]"/-->
    <div>
      <table border="1" align="center" width="100%">
        <tr>
          <th>Item</th>
          <th>Key</th>
          <th>Value</th>
        </tr>
        <xsl:apply-templates select="FoundList[@type = $maintype]"/>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="FoundList" name="iterator">
    <xsl:param name="count" select="$start"/>
    <xsl:variable name="size" select="count(.//Item)"/>
    <xsl:variable name="key" select=".//Item[$count][@name]"/>
    <xsl:variable name="value" select=".//Item[$count]/."/>

    <xsl:if test="($count &lt; $mainnumber) and ($count &lt; $size+1)">
      <xsl:call-template name="iterator2">
        <xsl:with-param name="counter" select="$count"/>
        <xsl:with-param name="key" select="$key"/>
        <xsl:with-param name="value" select="$value"/>
      </xsl:call-template>
      <xsl:call-template name="iterator">
        <xsl:with-param name="count" select="$count + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="iterator2">
    <xsl:param name="counter"/>
    <xsl:param name="key"/>
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$counter mod 2 = 0">
        <tr bgcolor="#B0C4DE">
          <td align="center">
            <xsl:value-of select="$counter"/>
          </td>
          <td>
            <xsl:value-of select="$key"/>
          </td>
          <td>
            <xsl:value-of select="$value"/>
          </td>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr bgcolor="#F5F5F5">
          <td align="center">
            <xsl:value-of select="$counter"/>
          </td>
          <td>
            <xsl:value-of select="$key"/>
          </td>
          <td>
            <xsl:value-of select="$value"/>
          </td>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>