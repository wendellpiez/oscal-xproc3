<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <!-- Binding XHTML namespace to 'html' prefix -->
   <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
   
   <sch:pattern>
     <sch:rule context="html:html | html:head | html:title | html:body | html:section | html:p | html:ul | html:ol | html:li | html:pre"/>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6"/>
      <sch:rule context="html:b | html:i | html:code | html:a | html:q"/>
      <sch:rule context="*">
         <sch:report test="true()">Element <sch:name/> is not expected in this HTML profile.</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section | html:body">
         <sch:assert test="text()[matches(.,'\S')] => empty()">Element <name/> has loose text contents.</sch:assert>
      </sch:rule></sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section/* | html:body/*">
         <sch:report test="preceding-sibling::node()[1]/self::text()[matches(.,'\S')] => exists()" role="warning">Look there ...</sch:report>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>