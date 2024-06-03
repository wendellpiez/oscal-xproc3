<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
   <sch:ns prefix="o" uri="http://csrc.nist.gov/ns/oscal/1.0"/>
   <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
   
   <xsl:key name="cross-references" match="o:control" use="@id"/>
   
   <sch:pattern>
      
      <sch:rule context="o:link[@rel=('related','required','incorporated-into','moved-to') and starts-with(@href,'#')]">
         <sch:let name="lookup" value="replace(@href,'^#(.*)$','$1')"/>
         <sch:assert id="broken-internal-link" test="exists(key('cross-references',$lookup))">Broken link to <sch:value-of select="$lookup"/></sch:assert>
      </sch:rule>
      
      <sch:rule context="o:prop">
         <sch:report test="false()"><sch:value-of select="@name"/>: <sch:value-of select="@value"/></sch:report>
      </sch:rule>
      
   </sch:pattern>
   
</sch:schema>