<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <!-- Binding XHTML namespace to 'html' prefix -->
   <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
   
   <sch:pattern>
      <sch:rule context="html:html | html:head | html:title | html:body | html:section |
         html:p | html:ul | html:ol | html:li | html:pre | html:details | html:summary"/>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6"/>
      <sch:rule context="html:b | html:i | html:code | html:a | html:q"/>
      <sch:rule context="html:table | html:thead | html:tbody | html:tr | html:th | html:td"/>
      <sch:rule context="*">
         <sch:report test="true()">Element <sch:name/> is not expected in this HTML profile.</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern id="errant-text">
      <sch:rule context="html:section | html:body">
         <sch:assert test="text()[matches(., '\S')] => empty()">Element <name/> has loose text contents.</sch:assert>
      </sch:rule>
      <sch:rule context="html:a[not(matches(@href,'^https?:'))]">
         <sch:assert test="unparsed-text-available(resolve-uri(@href,base-uri(.)))">Not seeing anything at href <sch:value-of select="@href"/></sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section/* | html:body/*">
         <sch:assert test="exists(self::html:section) or empty(preceding-sibling::html:section)">Element not expected following a section</sch:assert>
         <sch:report test="preceding-sibling::node()[1]/self::text()[matches(.,'\S')] => exists()" role="warning">Look there ...</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section | html:body">
         <sch:assert test="exists(parent::html:html|parent::html:body|parent::html:section)"><sch:name/> found out of place</sch:assert>
      </sch:rule>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
         <sch:let name="deep" value="count(ancestor::html:body | ancestor::html:section)"/>
         <sch:assert test="number(replace(local-name(), '\D', '')) = $deep"><sch:name/> found out of place - try
               h<sch:value-of select="$deep"/></sch:assert>
         <sch:assert test="empty(parent::* except (parent::html:body|parent::html:section))">Not expecting to see <name/> here</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   
   
   <sch:pattern>
      <sch:rule context="html:a">
         <sch:let name="internal" value="not(matches(@href,'^https?:/')) and matches(@href,'_src\.html$')"/>
         <sch:assert test="not(matches(.,'\.\S{2,4}$')) or (replace(.,'^.*/','') = replace(@href,'^.*/',''))">Internal link is misdirected</sch:assert>
         
         <sch:assert sqf:fix="tag-lessonUnit-link" test="@class='LessonUnit' or not($internal)">Link to lesson should be given @class='LessonUnit'</sch:assert>
         <sqf:fix id="tag-lessonUnit-link">
            <sqf:description>
               <sqf:title>Tag the link with class='LessonUnit'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="'LessonUnit'" target="class"/>
         </sqf:fix>  
      </sch:rule>
   </sch:pattern>

</sch:schema>