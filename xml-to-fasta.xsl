<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
  
  <xsl:preserve-space elements=""/>
  <xsl:strip-space elements=""/>

  <!-- variables and keys -->
  <xsl:variable name="n">
    <xsl:text>
</xsl:text>
  </xsl:variable>

  <xsl:template match="@*|node()">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <xsl:template match="t:TEI">
    <xsl:apply-templates/>
    <xsl:value-of select="$n"/>
    <xsl:value-of select="$n"/>
  </xsl:template>
  
  <xsl:template match="t:idno[@type='siglum']">
    <xsl:text>&gt;</xsl:text>
    <xsl:value-of select="."/>
    <xsl:value-of select="$n"/>
  </xsl:template>
  
  <xsl:template match="t:body//text()">
    <xsl:value-of select="normalize-space(translate(.,'/',' '))"/>
  </xsl:template>
    
</xsl:stylesheet>
