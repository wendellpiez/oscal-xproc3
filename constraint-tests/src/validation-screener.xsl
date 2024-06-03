<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   exclude-result-prefixes="#all" version="3.0">

   <xsl:mode on-no-match="shallow-copy"/>


   <xsl:function name="nm:doc-loc" as="xs:string">
      <xsl:param name="doc" as="node()"/>
      <xsl:value-of select="($doc/descendant::xvrl:metadata/xvrl:document/@href, $doc/descendant::svrl:active-pattern/@documents, $doc/@baseURI, $doc/@xml:base)[1]"/>
   </xsl:function>
   
   
   <xsl:function name="nm:returns-info" as="xs:boolean">
      <xsl:param name="doc" as="node()"/>
      <!--<c:errors SCHEMA="file:///C:/Users/wap1/Documents/usnistgov/oscal-xproc3/constraint-tests/link-constraints-mockup.sch"
         VALIDATION-MODE="Schematron"
         SCHEMA-VALIDATION-STATUS="INVALID"
         xmlns:c="http://www.w3.org/ns/xproc-step">-->
         
      <xsl:sequence select="$doc/descendant-or-self::c:errors[@SCHEMA-VALIDATION-STATUS='INVALID'] => exists()"/>
      <!--<xsl:sequence select="true()"/>-->
   </xsl:function>

   <xsl:template match="/*">
      <xsl:copy>
         <FOUND-VALID>
            <xsl:apply-templates select="*[nm:returns-info(.) => not() ]"/>
         </FOUND-VALID>
         <FOUND-INVALID>
            <xsl:apply-templates select="*[nm:returns-info(.)]" mode="reporting"/>
         </FOUND-INVALID>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="/*/*" mode="reporting">
      <document href="{ nm:doc-loc(.) }">
         <xsl:copy-of select="@VALIDATION-MODE, @SCHEMA, @SCHEMA-VALIDATION-STATUS"/>
         <xsl:copy-of select="."/>
      </document>
   </xsl:template>
   
   <xsl:template match="/*/*">
      <document href="{ nm:doc-loc(.) }">
         <xsl:copy-of select="@VALIDATION-MODE, @SCHEMA, @SCHEMA-VALIDATION-STATUS"/>
      </document>
   </xsl:template>
   
</xsl:stylesheet>