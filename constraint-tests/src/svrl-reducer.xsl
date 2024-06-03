<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   exclude-result-prefixes="xs math"
    expand-text="true"
   version="3.0">
   
   
  <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="c:*">
      <xsl:apply-templates/>
      </xsl:template>
       
   <xsl:template match="svrl:schematron-output">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="svrl:schematron-output/*">
      <xsl:message>{ name(. )}</xsl:message>
   </xsl:template>
   
   <xsl:template match="svrl:schematron-output/svrl:ns-prefix-in-attribute-values"/>
   
   <xsl:template match="svrl:schematron-output/svrl:metadata"/>
   
   <xsl:template match="svrl:schematron-output/svrl:active-pattern"/>
   
   <xsl:template match="svrl:schematron-output/svrl:fired-rule"/>
   
   <xsl:template match="svrl:schematron-output/svrl:failed-assert">
      <xsl:copy-of select="." copy-namespaces="false"/>
   </xsl:template>
   
   <xsl:template match="svrl:schematron-output/svrl:successful-report">
      <xsl:copy-of select="." copy-namespaces="false"/>
   </xsl:template>
   
   
</xsl:stylesheet>