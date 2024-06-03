<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   exclude-result-prefixes="xs math"
    expand-text="true"
   version="3.0">
   
   <xsl:template match="/*">
      <REPORT>
         <progress>Examining { count(*/*) }{ if (count(*/*) eq 1) then ' document' else ' documents' } ...</progress>

         <xsl:apply-templates select="child::*/document"/>

         <xsl:variable name="reports" select=".//svrl:failed-assert | .//svrl:successful-report"/>
         <xsl:sequence>
            <xsl:if test="empty($reports)">
               <summary>ALL GOOD - sample documents come up clean ...</summary>
            </xsl:if>
            <xsl:on-empty>
               <xsl:variable name="broken-docs" select="$reports/ancestor::document"/>
               <summary>WARNING - { if (count($reports) eq 1) then 'ISSUE' else 'ISSUES' } FOUND IN  { count($broken-docs) } { if (count($broken-docs) eq 1) then 'DOCUMENT' else 'DOCUMENTS' }</summary>
            </xsl:on-empty>
         </xsl:sequence>
      </REPORT>
   </xsl:template>
   
   <xsl:variable name="qname-qualifier" as="xs:string" expand-text="false">Q\{\S*?\}</xsl:variable>
   
   <xsl:template match="document">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="svrl:failed-assert">
      <xsl:variable name="loc" select="replace(@location,$qname-qualifier,'')"/>
      <finding xpath="{ $loc }">
         <xsl:copy-of select="@* except @location"/>
         <xsl:text>Failed assertion '{ @test }': </xsl:text>
         <xsl:apply-templates/>
      </finding>
   </xsl:template>
   
   <xsl:template match="svrl:successful-report">
      <xsl:variable name="loc" select="replace(@location,$qname-qualifier,'')"/>
      <finding xpath="{ $loc }">
         <xsl:copy-of select="@* except @location"/>
         <xsl:text>Report for '{ @test }': </xsl:text>
         <xsl:apply-templates/>
      </finding>
   </xsl:template>
   
</xsl:stylesheet>