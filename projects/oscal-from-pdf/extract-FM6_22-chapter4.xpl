<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   type="ox:MINIMAL"
   name="MINIMAL">


   <!-- For samples and boilerplate see file ../../projects/xproc-doc/xproc-snippets.xml -->
   
   <p:import href="src/validation-summarize.xpl"/>

   <p:option name="writing-all" static="true" select="false()"/>
   
   
   <p:output port="validation-reports" sequence="true"
      serialization="map{'omit-xml-declaration': true(), 'method': 'text', 'indent': true() }"/>
   
   <!-- These schemas must be in place for validations to be performed -->
   <!-- Break these to test pipeline behavior when they are missing  -->
   <p:variable name="sts-rng" select="'lib/NISO-STS-interchange-1-MathML3-RNG/NISO-STS-interchange-1-mathml3.rng'"/>
   <p:variable name="oscal-xsd" select="'lib/oscal_catalog_schema.xsd'"/>

   <!-- for data serialization -->
   <p:variable name="indented" select="map{'indent' : true() }"/>

   <!-- Anfangen  -->

   <p:load href="source/export/fm6_22.html"/>

   <!--
      
   The HTML coming in is poorly and incorrectly structured, with contents crammed into list items, even across section boundaries.
       
   In particular, Chapter 4 starts inside a list item within a purported list that spans across chapters.
   
   A filter deals with this by flattening all lists and marking where list bullets are presumed to appear. -->

   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml"
               exclude-result-prefixes="#all">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="ul">
                  <xsl:apply-templates/>
               </xsl:template>
               <xsl:template match="li">
                  <bullet  xmlns="http://www.w3.org/1999/xhtml"/>
                  <xsl:apply-templates/>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

   <p:store use-when="$writing-all" href="temp/t01.html" message="Saving flattened input"
      serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>

   <!-- Next we drop out everything but Chapter 4 using a crude but effective method on this data set-->
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml" expand-text="true">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:variable name="ch4_head" select="/*/body/p[normalize-space(.)='Chapter 4']"/>
               <xsl:variable name="ch5_head" select="/*/body/p[normalize-space(.)='Chapter 5']"/>
               <xsl:variable name="ch5" select="$ch5_head/(. | following-sibling::*)"/>
               <xsl:template match="body">
                  <xsl:copy>
                     <xsl:apply-templates select="$ch4_head/(. | following-sibling::*) except $ch5"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

   <p:store use-when="$writing-all" href="temp/t02.xml" message="Saving extracted chapter 4"
      serialization="$indented"/>

   <!-- Now we have content we can restructure - see the XSLTs for the logic -->

   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_structure.xsl"/>
   </p:xslt>

   <!-- Now with nested structures, although some collect multiple items (indicated by paragraph numbers) and tables (to be joined) -->
   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_restructure.xsl"/>
   </p:xslt>

   <p:store use-when="$writing-all" href="temp/t03_structured.xml" message="Saving chapter 4 re/structured" serialization="$indented"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6-html-to-sts.xsl"/>
   </p:xslt>

   <!-- This is valid STS, although not yet perfect -->
   <p:store use-when="$writing-all" href="temp/t04_sts-rough.xml" message="STS conversion - simple mapping" serialization="$indented"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_sts-enhance1.xsl"/>
   </p:xslt>

   <!-- p is either labeled (enumerated) as in the source, or collected into lists -->
   <p:store use-when="$writing-all" href="temp/t05_sts-corrected.xml" message="STS fixup" serialization="$indented"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_sts-enhance2.xsl"/>
   </p:xslt>

   <p:store use-when="$writing-all" href="temp/t06_sts-enhanced.xml" message="STS cleanup" serialization="$indented"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_sts-enhance3.xsl"/>
   </p:xslt>

   <!-- Saving before we validate, because validation produces a report as primary result-->
   <p:store name="best-sts" message="SAVING STS best-so-far - temp/FM_6-22-STS.xml" href="temp/FM_6-22-STS.xml" serialization="$indented"/>

   <p:choose name="sts-validation">
      <p:when test="doc-available($sts-rng)">
         <p:output port="report" pipe="report@sts-rng-validation"/>
         <p:validate-with-relax-ng assert-valid="false" name="sts-rng-validation"
            message="Validating STS against RNG schema { $sts-rng }">
            <p:with-input port="schema">
               <p:document href="{ $sts-rng }"/>
            </p:with-input>
         </p:validate-with-relax-ng>
      </p:when>
      <p:otherwise>
         <p:output port="report" pipe="result@no-rng"/>
         <p:identity
            message="Not validating STS - no schema found at { $sts-rng } - try running pipeline GRAB-NISO_STS-RNG.xpl"
            name="no-rng">
            <p:with-input port="source">
               <p:inline>
                  <ox:message>Schema { $sts-rng } not found - try running pipeline
                     GRAB-NISO_STS-RNG.xpl</ox:message>
               </p:inline>
            </p:with-input>
         </p:identity>
      </p:otherwise>
   </p:choose>

   <ox:validation-summarize name="summarize-sts-validation">
      <p:with-option name="doc-name" select="'the STS result'"/>
      <p:with-option name="schema-name" select="$sts-rng"/>
   </ox:validation-summarize>

   <!-- Now we have STS and have checked it, we can produce OSCAL -->

   <!-- The pipeline source reaches back to the 'best-sts' step for its input -->
   <p:xslt>
      <p:with-input port="source" pipe="result@best-sts"/>
      <p:with-input port="stylesheet" href="src/fm22-6_sts-to-oscal.xsl"/>
   </p:xslt>

   <p:store use-when="$writing-all" name="oscalized-sts" message="Saving OSCAL - temp/t16_oscalized.xml" href="temp/t16_oscalized.xml" serialization="$indented"/>
   
   <!-- Some whitespace cleanup after XSLT shuffling -->
   <p:string-replace xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"
      match="o:p/text()[1][empty(preceding-sibling::*)]" replace="replace(.,'^\s+','')"/>
   
   <p:string-replace xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"
      match="text()" replace="replace(.,'\(starting on page 4-4\)','')"/>
   
   <p:string-replace xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"
      match="text()" replace="replace(.,' on page 4\-\d\d?','')"/>
   
   <p:xslt name="oscal-whitespace">
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="*" expand-text="true">
                  <xsl:variable name="indent">{ ancestor::*/'  ' => string-join('') }</xsl:variable>
                  <xsl:text>{ parent::element()/'&#xA;' }{ $indent }</xsl:text>
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:apply-templates/>
                     <xsl:if test="exists(child::*) and empty((.|..)/child::text()[matches(.,'\S')])">&#xA;{ $indent }</xsl:if>
                  </xsl:copy>
               </xsl:template>
               <xsl:template match="*[../child::text()[matches(.,'\S')] => exists() ]">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:apply-templates/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:store name="oscal" message="SAVING OSCAL - temp/FM_6-22-OSCAL.xml" href="temp/FM_6-22-OSCAL.xml"/>

   <p:choose name="oscal-validation">
      <p:when test="doc-available($oscal-xsd)">
         <p:output port="report" pipe="report@oscal-xsd-validation"/>
         <p:validate-with-xml-schema assert-valid="false" name="oscal-xsd-validation"
            message="Validating OSCAL against XSD { $oscal-xsd }">
            <p:with-input port="schema">
               <p:document href="{ $oscal-xsd }"/>
            </p:with-input>
         </p:validate-with-xml-schema>
      </p:when>
      <p:otherwise>
         <p:output port="report" pipe="result@no-xsd"/>
         <p:identity message="Not validating OSCAL - no schema found at { $oscal-xsd }" name="no-xsd">
            <p:with-input port="source">
               <p:inline>
                  <ox:message>Schema { $oscal-xsd } not found - try running pipeline GRAB-RESOURCES.xpl</ox:message>
               </p:inline>
            </p:with-input>
         </p:identity>
      </p:otherwise>
   </p:choose>

   <ox:validation-summarize name="summarize-oscal-validation">
      <p:with-option name="doc-name"    select="'the OSCAL result'"/>
      <p:with-option name="schema-name" select="$oscal-xsd"/>
   </ox:validation-summarize>

   <p:validate-with-schematron assert-valid="false" name="schematron-validator">
      <p:with-input port="source" pipe="result@oscal"/>
      <p:with-input port="schema" href="src/oscal-check.sch"/>
   </p:validate-with-schematron>
   
   <ox:validation-summarize name="summarize-oscal-schematron">
      <p:with-input port="validation-report" pipe="report@schematron-validator"/>
      <p:with-option name="doc-name"    select="'the OSCAL result'"/>
      <p:with-option name="schema-name" select="'src/oscal-check.sch'"/>
   </ox:validation-summarize>
   
   <p:wrap-sequence wrapper="REPORTS" name="validation-reports">
      <p:with-input port="source">
         <p:pipe step="summarize-sts-validation"   port="summary"/>
         <p:pipe step="summarize-oscal-validation" port="summary"/>
         <p:pipe step="summarize-oscal-schematron" port="summary"/>
      </p:with-input>
   </p:wrap-sequence>
   
   <!-- Adding a bit of whitespace so a 'text method' serialization looks okay. -->
   <p:insert match="ox:message" position="before">
      <p:with-input port="insertion">
         <p:inline>&#xA;</p:inline>
      </p:with-input>
   </p:insert>
   
   <p:namespace-delete prefixes="c xsl svrl ox xvrl"/>
</p:declare-step>