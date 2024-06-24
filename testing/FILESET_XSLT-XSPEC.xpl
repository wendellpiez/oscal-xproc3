<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:FILESET_XSLT-XSPEC"
   name="FILESET_XSLT-XSPEC">

   <!-- Pipeline to be called as subpipeline, delivering a sequence of XSpec files, parsed as XML -->

   <!-- Strictly diagnostic or demonstration XSpecs can be excluded from this list,
        while the rule for CI/CD is "Paranoia is my good friend". -->

   <p:input port="source" sequence="true">
      <!-- We need content type because xspec suffix throws off the parser -->
      <p:document href="../smoketest/congratulations-xslt.xspec" content-type="application/xml"/>
      
   </p:input>
 
   <p:output port="xspec-files" sequence="true"/>
   
   <p:identity/>
   
</p:declare-step>