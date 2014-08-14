<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <!--Main Template-->
  <xsl:template match="/">
    <span id="mainspan">
      <span id="status"/>
      <xsl:choose>
        <xsl:when test="count(//row) &lt; 1">
          <p style="font-weight:bold;font-size:12px;color:red;text-align:center">
            <xsl:text disable-output-escaping="yes">ERROR: No records found for given specifications.</xsl:text>
          </p>
        </xsl:when>
        <xsl:otherwise>

          <!--Get all distinct accounts-->
          <xsl:variable name="unique_rows" select="//root/row[not (@ACCT_ID = preceding-sibling::row/@ACCT_ID)]/@ACCT_ID"/>

          <!--Get all distinct currencies-->
          <xsl:variable name="unique_ccys" select="//root/row[not (@CURRENCY = preceding-sibling::row/@CURRENCY)]/@CURRENCY"/>

          <!--Get count of all unposted posts-->
          <xsl:variable name="types" select="count(//root/row[@POSTED = '0'])"/>
          
          <!--Start creating table-->
          <table border="1" width="100%">
            <tr>
              <table border="0" width="100%" style="border-style:ridge ridge none ridge;border-width:thin;border-color:red">
                <xsl:call-template name="displayHeader">
                  <xsl:with-param name="currencies" select="$unique_ccys"/>
                </xsl:call-template>

                <!--Populate each distinct account details-->
                <xsl:for-each select="$unique_rows">
                  <xsl:sort select="." data-type="text" order="ascending"/>
                  <xsl:call-template name="displayItems">
                    <xsl:with-param name="acct_id" select="."/>
                    <xsl:with-param name="currencies" select="$unique_ccys"/>
                  </xsl:call-template>
                </xsl:for-each>
              </table>
            </tr>
          </table>
          <!--Populate the last submit link-->
          <xsl:call-template name="displayFooter">
            <xsl:with-param name="position_y" select="count($unique_rows)"/>
            <xsl:with-param name="types" select="$types"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  
  <!-- Display the details of an account given an ACCOUNT ID.
      Also display checkboxes for each account.
  -->
  <xsl:template name="displayItems">
    <xsl:param name="acct_id"/>
    <xsl:param name="currencies"/>
    <xsl:variable name="rows" select="//row[@ACCT_ID=$acct_id]"/>
    <tr>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="position() mod 2 = 0">odd</xsl:when>
          <xsl:otherwise>even</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <td>
        <xsl:value-of select="normalize-space($acct_id)"/>
      </td>
      <xsl:for-each select="$currencies">
        <xsl:sort select="." data-type="text" order="ascending"/>
        <xsl:variable name="item" select="."/>
        <td align="right">
          <xsl:attribute name="id">
            <xsl:text>CCY_</xsl:text>
            <xsl:value-of select="position()"/>
          </xsl:attribute>
          <xsl:text>&#160;</xsl:text>
          <!--For all the currencies we have, if the current account has that currency info,
              populate the data; if not, leave a blank space.-->
          <!--
          <xsl:for-each select="$rows">
            <xsl:sort select="./@CURRENCY" data-type="text" order="ascending"/>
            <xsl:choose>
              <xsl:when test="(@CURRENCY = $item) and (string-length(@AMOUNT) > 0)">
                <xsl:value-of select="format-number(./@AMOUNT, '###,##0.00')"/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
          -->
          <xsl:if test="$rows[@CURRENCY=$item] and (string-length($rows[@CURRENCY=$item]/@AMOUNT) > 0)">
            <xsl:value-of select="format-number($rows[@CURRENCY=$item]/@AMOUNT, '###,##0.00')"/>
          </xsl:if>
          
        </td>
      </xsl:for-each>
      <!--Checkbox-->
      <td align="center">
        <input type="checkbox" class="acct_checkboxes">
          <xsl:choose>
            <xsl:when test="$rows[1]/@POSTED='1'">
              <xsl:attribute name="name">
                <xsl:text>posted~</xsl:text>
                <xsl:value-of select="normalize-space($acct_id)"/>
              </xsl:attribute>
              <xsl:attribute name="checked"/>
              <xsl:attribute name="disabled"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="name">
                <xsl:text>unposted~</xsl:text>
                <xsl:value-of select="normalize-space($acct_id)"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </input>
      </td>
    </tr>
  </xsl:template>

  <!--<Display the header of the table given an account id
      Also display "Check All"/"Uncheck All" link.>-->
  <xsl:template name="displayHeader">
    <xsl:param name="currencies"/>
    <xsl:variable name="split-width" select="count($currencies)"/>
    <tr>
      <td class="title_left" width="30%">Account/Currency</td>
      <xsl:for-each select="$currencies">
        <xsl:sort select="." data-type="text" order="ascending"/>
        <td class="title_right">
          <xsl:attribute name="width">
            <xsl:value-of select="60 div $split-width"/>
            <xsl:text>%</xsl:text>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </td>
      </xsl:for-each>
      <td width="10%" align="center" class="odd">
        <a href="javascript:perform_check('acct_checkboxes')" id="acct_checkboxes" style="align:center;font-size:10px">Select All</a>
      </td>
    </tr>
  </xsl:template>

  <!--Display the submit button at bottom-->
  <xsl:template name="displayFooter">
    <xsl:param name="position_y"/>
    <xsl:param name="types"/>
    <table width="100%" style="border-style:none ridge ridge ridge;border-width:thin;border-color:red">
      <tr width="100%">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="($position_y + 1) mod 2 = 0">odd</xsl:when>
            <xsl:otherwise>even</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <td align="center" width="100%">
          <a href="javascript:activatePost('acct_checkboxes')" id="submit_link">
            <xsl:if test="$types &lt; 1">
              <xsl:attribute name="style">display:none</xsl:attribute>
            </xsl:if>
            <img src="../../images/img_submit.gif" border="0" alt="Submit Posting" style="position:relative" />
          </a>
        </td>
      </tr>
    </table>
  </xsl:template>  
</xsl:stylesheet>