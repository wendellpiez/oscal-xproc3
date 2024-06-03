<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:catalogs-for-testing"
   name="catalogs-for-testing"
   >

   <!-- Pipeline to be called as subpipeline, delivering a list of XProcs -->
   
   <p:input port="source" sequence="true">
      <p:document href="reference-sets/catalog-constraints/example_moderate_profile_resolved.xml"/>
      <p:document href="reference-sets/catalog-constraints/test-catalog.xml"/>
   </p:input>
 
   <p:output port="oscal-documents" sequence="true"/>
   
   <p:identity/>
   
</p:declare-step>
