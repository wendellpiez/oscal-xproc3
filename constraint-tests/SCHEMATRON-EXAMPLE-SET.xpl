<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:SCHEMATRON-EXAMPLE-SET"
   name="SCHEMATRON-EXAMPLE-SET">

   <!-- Note: this doesn't run without an available copy of SchXSLT -
        to be set up in ../lib -->
   
   <p:import href="catalogs-for-testing.xpl"/>
   
   <p:output port="result" serialization="map{'indent' : true()}"/>
   
   <p:variable name="schematron-path" select="'link-constraints-mockup.sch'"/>
   
   <ox:catalogs-for-testing name="catalogs-for-testing"/>
   
   <p:for-each>
      <p:with-input pipe="oscal-documents@catalogs-for-testing"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:try>
         <p:group name="validation">
            <p:variable name="base" select="base-uri(/*)"/>
            <!-- assert-valid='true' presents c:errors results when validation fails as 'no failed assertions or successful reports' -->
            <p:validate-with-schematron assert-valid="true"  message="[SCHEMATRON-EXAMPLE-SET] Validating { $base } against { $schematron-path }">
               <p:with-input port="schema" href="{$schematron-path}"/>
            </p:validate-with-schematron>
            
            <p:add-attribute attribute-name="baseURI" attribute-value="{$base}"/>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="VALID"/>
         </p:group>
         <p:catch>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="INVALID"/>
         </p:catch>
      </p:try>
      <p:add-attribute attribute-name="VALIDATION-MODE" match="/*" attribute-value="Schematron"/>
      <p:add-attribute attribute-name="SCHEMA" attribute-value="{ $schematron-path => resolve-uri() }"/>
   </p:for-each>
      
   <p:wrap-sequence name="wrapup" wrapper="ALL-REPORTS"/>
      
   <p:xslt name="assessment" message="[SCHEMATRON-EXAMPLE-SET] Assessing ...">
      <p:with-input port="stylesheet" href="src/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="reduction" message="[SCHEMATRON-EXAMPLE-SET] Reducing ...">
      <p:with-input port="stylesheet" href="src/svrl-reducer.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[SCHEMATRON-EXAMPLE-SET] Summarizing ...">
      <p:with-input port="stylesheet" href="src/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements  -->
      <p:with-input port="stylesheet" href="src/summary-plaintext.xsl"/>
   </p:xslt>
   
</p:declare-step>

