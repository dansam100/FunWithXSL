<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <xsl:call-template name="embed_css"/>
      <div class="searchlist">
        <table class="maxpvtable" align="center" border="1">
          <tr>
            <th class="heading">User Information:</th>
            <td class="gooditem">
              <xsl:value-of select="Logger/@user"/>@<xsl:value-of select="Logger/@machine"/>
            </td>
          </tr>
        </table>
        <table class="maintable" align="center" border="1" width="100%">
          <tr align="center">
            <th class="heading">Level</th>
            <th class="heading">Date/Time</th>
            <th class="heading">Message</th>
          </tr>
            <xsl:apply-templates/>
        </table>
      </div>
    </html>
  </xsl:template>

  <xsl:template match="header">
    <span class="mainspan" style="text-align:center">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="Log">
    <tr>
      <td class="gooditem">
        <xsl:value-of select="@level"/>
      </td>
      <td class="gooditem">
        <xsl:value-of select="@date"/>@<xsl:value-of select="@time"/>
      </td>
      <td class="gooditem">
        <xsl:value-of select="./message"/>
      </td>
    </tr>    
  </xsl:template>

  <xsl:template match="footer">
    <span class="mainspan" style="text-align:center">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
  <xsl:template name="embed_css">
    <head>
      <link rel="stylesheet" type="text/css" href="configuration.css"/>
    </head>
  </xsl:template>
</xsl:stylesheet>