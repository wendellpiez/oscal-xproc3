<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all" expand-text="true">

   <!-- Purpose: consumes results of validation-summarizer.xsl and emits plain text,
     with some ornamentation -->

   <xsl:mode on-no-match="text-only-copy"/>

   <xsl:variable name="project-uri" select="resolve-uri('..',static-base-uri())"/>
   
   <xsl:template match="/*">
      <xsl:apply-templates/>
      <xsl:text>&#xA;{ (1 to 12) ! ':::::' }</xsl:text>
   </xsl:template>

   <xsl:template match="summary" priority="10">
      <xsl:text>&#xA;</xsl:text>
      <xsl:apply-templates select="../child::finding" mode="decoration"/>
      <xsl:next-match/>
   </xsl:template>

   <xsl:template mode="decoration" match="finding[@status = 'confirmed']">good</xsl:template>
   <xsl:template mode="decoration" match="finding">BAD!</xsl:template>

   <xsl:template match="REPORT/document">
      <xsl:text>&#xA;Document at </xsl:text>
      <xsl:apply-templates select="@href"/>
      <xsl:text>: { @SCHEMA-VALIDATION-STATUS }</xsl:text>
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="@href">{ substring-after(.,$project-uri) }</xsl:template>

   <xsl:template match="finding">
      <xsl:text>&#xA;Finding -- </xsl:text>
      <xsl:apply-templates/>
      <xsl:text> on { @xpath }</xsl:text>
   </xsl:template>
   
   
</xsl:stylesheet>