<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/Configuration/Programs/ProgHasher">
    <html>
      <h2 class="mainheading" align="center">Hasher Configuration</h2>
      <head>
        <link rel="stylesheet" type="text/css" href="configuration.css" />
      </head>
      <body>
        <span class="mainspan">
          <xsl:apply-templates/>
        </span>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="MaxPerFolder">
    <div class="maxperfolder">
      <span>
        <table align="center" width="100%" border="1" class="maxpvtable">
          <tr>
            <th align="left" width="20%" class="subheading">Max Per Folder</th>
            <td align="left" class="maxPV">
              <span onmouseover="this.parentNode.className='itemmouseover'" onmouseout="this.parentNode.className='maxPV'">
                <xsl:value-of select="."/>
              </span>
            </td>
          </tr>
        </table>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="SearchList">
    <div class="searchlist">
      <table align="center" border="1" width="100%" class="maintable">
        <tr>
          <th colspan="2" align="center" class="heading">
            Search Lists
          </th>
        </tr>
        <xsl:for-each select="./*">
          <tr>
            <th width="20%" class="subheader">
              <span>
                <xsl:value-of select="name()"/>
              </span>
              <br/>
              <span class="miniheader">
                (<xsl:value-of select="@extensions"/>)
              </span>
            </th>
            <td>
              <xsl:apply-templates/>               
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="HashFirst">
    <table width="100%" border="1" class="itemtable">
      <tr>
        <th class="microheader">Hash First</th>
      </tr>
      <tr>
        <td>
          <table cellpadding="3px">
            <xsl:for-each select="Location">
              <tr>
                <td class="gooditem">
                  <span onmouseover="this.parentNode.className='itemmouseover'" onmouseout="this.parentNode.className='gooditem'">
                    <xsl:value-of select="."/>
                  </span>
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="HashAfter">
    <table width="100%" border="1" class="itemtable">
      <tr>
        <th class="microheader" align="center">Hash After</th>
      </tr>
      <tr>
        <td>
          <table cellpadding="3px">
            <xsl:for-each select="Location">
              <tr>
                <td class="gooditem">
                  <span onmouseover="this.parentNode.className='itemmouseover'" onmouseout="this.parentNode.className='gooditem'">
                    <xsl:attribute name="class">
                      item<xsl:value-of select="position()" />
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                  </span>
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="ExclusionList">
    <table border="1" align="center" cellpadding="3px"  width="100%" class="baditemtable">
      <tr>
        <th class="heading" align="center">Exclude List</th>
      </tr>
      <xsl:for-each select="Regex">
        <tr>
          <td class="baditem" align="left">
            <span onmouseover="this.parentNode.className='itemmouseover'" onmouseout="this.parentNode.className='baditem'">
              <xsl:attribute name="class">
                exclude<xsl:value-of select="position()" />
              </xsl:attribute>
              <xsl:value-of select="."/>
            </span>
          </td>          
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="Legend">
    
  </xsl:template>
</xsl:stylesheet>