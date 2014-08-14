<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  
  <xsl:template match="/data">
    <span id="mainspan">
      <xsl:choose>
        <xsl:when test="count(//account) &lt; 1">
          <p style="font-weight:bold;font-size:12px;color:red;text-align:center">
            <xsl:text disable-output-escaping="yes">ERROR: No records found for given specifications.</xsl:text>
          </p>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="embed_script"/>
          <table border="1" width="100%">
            <xsl:apply-templates/>
          </table>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="currency" name="header">
    <tr>
      <th>Account/Currency</th>
      <xsl:for-each select="ccy">
        <xsl:sort select="@name" data-type="text" order="ascending"/>
        <th><xsl:value-of select="@name"/></th>
      </xsl:for-each>
      <td width="50px">
        <a onClick="perform_check()"
          style="cursor:hand;text-decoration:underline;color:blue;align:center;font-size:10px"
          id="perform_check">Select All</a>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="account" name="display">
    <tr>
      <td>
        <xsl:value-of select="@name"/>
      </td>
      <xsl:variable name="this_account" select="./currency"/>
        <xsl:for-each select="parent::node()/currency/ccy">
          <xsl:sort select="./@name" data-type="text" order="ascending"/>
          
          <xsl:variable name="item" select="@name"/>
          <td align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:for-each select="$this_account">
              <xsl:choose>
                <xsl:when test="@name = $item">
                    <xsl:value-of select="format-number(./@value, '###,##0.00')"/>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </td>
        </xsl:for-each>
      <td>
        <input type="checkbox" class="acct_checkboxes">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </input>
      </td>
    </tr>
  </xsl:template>

  <!--Embed script for handling checking and unchecking of checkboxes.-->
  <xsl:template name="embed_script">
    <noscript>Unable to perform actions on page.</noscript>
    <script type="text/javascript">
      function getCheckBoxes(classname)
      {
      var all_inputs = document.getElementsByTagName("input");
      var checkboxes = [];
      for(var i in all_inputs)
      {
      if(all_inputs[i].className == classname)
      checkboxes.push(all_inputs[i]);
      }
      return checkboxes;
      }

      function perform_check()
      {
      var check_link = document.getElementById("perform_check");
      if(check_link != null)
      {
      if(check_link.innerText == "Select All")
      {
      var checkboxes = getCheckBoxes("acct_checkboxes");
      for(var i in checkboxes)
      {
      checkboxes[i].checked = true;
      }
      check_link.innerText = "Uncheck All";
      }
      else if(check_link.innerText == "Uncheck All")
      {
      var checkboxes = getCheckBoxes("acct_checkboxes");
      for(var i in checkboxes)
      {
      checkboxes[i].checked = false;
      }
      check_link.innerText = "Select All";
      }
      }
      }
    </script>
  </xsl:template>
</xsl:stylesheet>