

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/walkthrough/walkthrough_219_src.html](../../source/walkthrough/walkthrough_219_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 219: XProc, XML and XDM (the XML Data Model)

## Goals

* Consider XProc in its operational context including available **standards** and applicable **requirements**, both generalized and local
* Consider the context of XProc by learning or relearning some deep XML history
* Inform your capability to assess the utility and appropriateness of XProc in particular and XML in general, for a given problem or domain

## Resources

The same pipelines you ran in setup: [Setup             101](../acquire/acquire_101.md).

Also, [XProc.org dashboard page](https://xproc.org).

Also, XProc index materials produced in this repository: [XProc docs](../../../projects/xproc-doc/readme.md).

## XProc as XML

XProc is defined as an XML vocabulary. A schema for the XProc language, considered as core steps (compound and atomic) plus optional community-defined steps, is referenced from the [XProc Specification](https://spec.xproc.org/3.0/xproc/#ancillary-files). [This RNG schema](https://spec.xproc.org/3.0/xproc/xproc30.rng) is very useful.

It may often be considered gratuitous to validate XProc files against a schema, when the application (whether it be Morgana, XML Calabash or other) must in any case take responsibility for conformance issues, as it sees fit. The reference schema becomes useful if we find or suspect bugs in processor features, but until then it need not have any direct role in any runtime operation.

Nevertheless, since XProc is XML, its schema still serves as a reference and an object for querying – queries whose results tell us about XProc. [A pipeline](../../GRAB-XPROC-RESOURCES.xpl) for acquiring both the RNG schema. and its RNC (compact syntax) variant. are provided for interest and possible later use.

### Survey of XProc elements

All elements defined by XProc (at time of writing) are listed in this analytical breakout.

*However*, this list is provisional and intended only to offer a wider view. For the most up to date information, refer to specifications. In particular, XProc 3.1 makes this list a moving target. This may be out of date by the time you are able to read it.

 NB also – see Erik Siegel's [XProcRef](https://xprocref.org/index.html) indexing project for more detailed summaries.

| Function | XProc elements / p: namespace |
| Documentation | `p:documentation` |
| Top-level | `p:declare-step`, `p:library` |
| Imports | `p:import`, `p:import-functions` |
| Prologue | `p:input`, `p:output`, `p:option` |
| Compound steps | `p:group`, `p:for-each`, `p:viewport`, `p:if`, `p:choose` (with `p:when` and `p:otherwise`), `p:try` (with `p:catch` and `p:finally)`, `p:run` (with `p:run-input`, `p:run-option`) |
| Atomic steps - core - XML | `p:add-attribute`, `p:add-xml-base`, `p:delete`, `p:filter`, `p:identity`, `p:insert`, `p:label-elements`, `p:make-absolute-uris`, `p:namespace-delete`, `p:namespace-rename`, `p:pack`, `p:rename`, `p:replace`, `p:set-attributes`, `p:uuid`, `p:unwrap`, `p:wrap-sequence`, `p:wrap`, `p:xinclude`, `p:xquery`, `p:xslt` |
| Atomic steps - core - zipping | `p:archive`, `p:archive-manifest`, `p:unarchive`, `p:uncompress` |
| Atomic steps - core - JSON | `p:json-join`, `p:json-merge`, `p:set-properties` |
| Atomic steps - core - plain text | `p:string-replace`, `p:text-count`, `p:text-head`, `p:text-join`, `p:text-replace`, `p:text-sort`, `p:text-tail` |
| Atomic steps - core - utility | `p:cast-content-type`, `p:compare`, `p:compress`, `p:count`, `p:error`, `p:hash`, `p:http-request`, `p:load`, `p:sink`, `p:split-sequence`, `p:store`, `p:www-form-urldecode`, `p:www-form-urlencode` |
| Atomic steps - optional - file system | `p:directory-list`, `p:file-copy`, `p:file-delete`, `p:file-info`, `p:file-mkdir`, `p:file-move`, `p:file-create-tempfile`, `p:file-touch` |
| Atomic steps - optional - validation | `p:validate-with-nvdl`, `p:validate-with-relax-ng`, `p:validate-with-schematron`, `p:validate-with-xml-schema`, `p:validate-with-json-schema` |
| Other optional steps | `p:os-info`, `p:os-exec`, `p:css-formatter`, `p:xsl-formatter`, `p:markdown-to-html` |
| Variable declaration | `p:variable` |
| Connectors | `p:with-input`, `p:with-option`, `p:pipe`, `p:pipeinfo`, `p:document`, `p:inline`, `p:empty` |

## XML and the XML Data Model (XDM): context and rationale

XML (Extensible Markup Language) is a text-based data format. XDM (the XML Data Model) is an abstract object model defining types and interfaces. XDM is designed to provide tools that work with XML data with a common model, permitting the description and specification of arbitrary operations of instances. XDM provides the conceptual foundation of XPath, XSLT and XQuery.

These technologies have been developed under the auspices of the World Wide Web Consortium (W3C) and other standards bodies since before the publication of XML in 1998. This longevity is not an accident: for stability over a long term (years and decades rather than months), we have required solutions that are:

* Standard, non-proprietary and freely available without restriction
* Consistently and repeatedly shown to be capable at scale (size/complexity)
* Supported by commodity tools, easing problems of proprietary product dependencies

Importantly, we need tools that are freely available to use without restriction, an important qualification for this distribution, which has a prior commitment *not to endorse particular technological solutions to any problem*, however posed or circumscribed. Accordingly, solutions here are not offered as recommendations, but rather as stipulations of (minimum) viable functionality in tools or capabilities, and not only using tools as &ldquo;black boxes&rdquo;, but under control and conformant to external specifications – i.e., standards.

Users should keep in mind the model whereby we imagine the viability of a tools market and ecosystem that enables both large and small software developers – including independent developers, academic researchers, and students – to participate meaningfully, finding an appropriate value or service proposition to support immediate and long-term goals. Translated, this means the tools must be capable enough for industrial use at scale, while they must also &ldquo;scale down&rdquo; to demonstration or classroom use.

In web standards including HTML and Javascript (ECMAScript) we arguably have the beginnings of such an ecosystem, while it is also contested and turbulent. Within the publishing sector more broadly and intersecting with the web, the XML family of standards arguably provides the best demonstration of complete or near-complete capabilities at least with respect to the harder problems of document processing.

* XSLT up to [XSLT 3.0](https://www.w3.org/TR/xslt-30/) (in [Saxon](https://www.saxonica.com/welcome/welcome.xml))
* [XQuery](https://www.w3.org/TR/xquery-31/) (in Saxon)
* [Schematron](https://github.com/Schematron) (in [SchXSLT](https://github.com/schxslt/schxslt), an open-source implementation in XSLT of [Schematron](https://schematron.com/) including the [ISO/IEC 19757-3](https://www.iso.org/obp/ui/#iso:std:iso-iec:19757:-3:ed-3:v1:en) specification
* [XSpec](https://github.com/xspec/xspec), a community-maintained XSLT-based framework for test-driven development, supporting testing XSLT, XQuery and Schematron

Since they are known to be highly conformant to their respective specifications as well as well tested, these tools provide a useful functional baseline for evaluating other tooling that addresses the same functional requirements.

They are also, relatively speaking, *mature* technologies, at least in comparison to similar offerings.

And when XProc works, we also have the functional underpinnings we need for comparing – for example – different XSLT implementations.

Initiated in 1996, XML continues to be generative in 2024.

## Snapshot history: an XML time line

[TODO] Evidently we could use help completing and fact checking all this...

| Year | Publication | Capabilities | Processing frameworks | Platforms |
| --- | --- | --- | --- | --- |
| 1987 | SGML (ISO-IEC 8879-1) | parsing logic; schema validation; configurable syntax; (implicit) tree of elements and attributes | Proprietary stacks | Mainframes, workstations |
| 1996 | Unicode 2.0 | standard character sets | … support for Unicode is slow to come | PCs |
| 1998 | XML 1.0 | standard syntax | Batch processing, shell scripts, `make` | Mainframes, workstations, PCs (x86 generation), *nix, shell, sed/awk, Perl |
| 1999 | XPath 1.0, XSLT 1.0 | basic tree querying and transformations (&ldquo;down hill&rdquo;); functional support for namespaces | Web browsers? (some, sort of); standalone XSLT processors |  |
| 2000 |  | XML-configured software builds | Apache Ant | Java |
|  |  |  |  | Perl, Python |
|  | XQuery 1.0 |  |  |  |
|  | XPath 2.0 |  | Server frameworks (Apache Cocoon) |  |
| 2001 | XML Schema Definition language (XDM) | Standardizes atomic data types (foundations of XSD); namespace-based validation (RNG also offers this, 2001-2002) |  |  |
| 2001-2003 | (Conference papers) | Early pipelining demonstrations |  |  |
| 2003 |  | Pipelining as a build process | Apache Ant | Java |
| 2003-2004 | W3C Document Object Model (DOM) | API for HTML and XML documents |  |  |
| 2005 | &ldquo;The XML data model&rdquo; (W3C) | [An essay](https://www.w3.org/XML/Datamodel.html) |  |  |
| 2006 | XProc 1.0 Requirements |  |  | Proof-of-concept demonstrations |
| 2007 | XSLT 2.0 | Transformations (&ldquo;up hill&rdquo;) including grouping, string processing, pipelining |  |  |
|  | XDM (XPath/XQuery data model) | Unifying a data model for XPath, XSLT and XQuery |  | Client- and server-side XML processing stacks |
|  |  |  | XQuery+XSLT in eXist-db or BaseX (XQuery engines) |  |
| 2010 | XProc 1.0 | Standard vocabulary for XDM-based pipelining |  |  |
| 2014 | XPath 3.0 | JSON interchange support |  |  |
| 2017 | XSLT 3.0/3.1 | JSON harmonization; higher-order functions; map and array objects |  |  |
| 2022 | XProc 3.0 | Improves on XProc 1.0 with easier syntax, plus adding support for JSON and other content types |  |  |
| 2022 | Unicode 15.0 |  |  |  |

The technologies have been in constant use over this period.

Historically, the requirements of processing frameworks have often been met by software developers' build utilities (for example, GNU `make` or Apache Ant). This is not an accident: in certain respects, a publishing framework can be considered as a &ldquo;documentary build&rdquo;, to be run at intervals corresponding to the publishing cycle with its proof runs.

## XPath

Like other XDM-based technologies, XProc embeds and incorporates XPath, an expression language for XML. XPath 3.0 is a functional language in its own right, although not designed for end-to-end processing of encoded source data into encoded results, but only for certain critical operations that ordinarily need to be performed within such end-to-end processing. Importantly, XPath is defined not in terms of any data notation (such as XML syntax or any other) but rather against an *abstract data object*, namely an [XDM](https://www.w3.org/TR/xpath-datamodel/) instance (XML data model), a putative information object that may be provided to the system by parsing an XML (syntax) instance, or by other means. As the query language for [XDM](https://www.w3.org/TR/xpath-datamodel/) and the basis for XQuery, [XPath](https://www.w3.org/TR/xpath-31/) is the &ldquo;other half&rdquo; of the data model, which any architect of a system using this technology must know. Learning XPath equips you mentally for dealing with the XDM in XQuery, XSLT, XProc or anywhere you find it.

For those not already familiar with XPath, on line resources can be helpful. Keep in mind that [XPath 3.1](https://www.w3.org/TR/xpath-31/) outstrips earlier versions of the language in many important respects, supporting map and function objects with higher-order functions among other features.

### Documents and data

One of the more important features of XPath and the XDM is that they are designed not only to meet needs for the representation and transmission of structured data. A specialized class of data formats has evolved that represent information in ways that are not &ldquo;unstructured&rdquo;, but that contrast with more common or usual structures of data formats, whether they be tabular data, serialization formats for object models, or some other regular (formalized and codified) arrangement for purposes of machine-readability. One might say &ldquo;common&rdquo; or &ldquo;usual&rdquo; with reservation, since of course documents are not uncommon where they are common. The predominance of so-called &ldquo;structured data&rdquo; in digital systems may tell us more about the limits of those systems, considered within their historical and evolutionary context, than it does about information in general.

At the same time it does not seem like a mistake to identify &ldquo;information&rdquo; with &ldquo;structure&rdquo;, or at least to observe there is a mutual and perhaps definitional interdependence there.

We see a great deal of structured data these days if only because it is so easy to make structured data with machines, and we now have the machines. What remains difficult is to translate something that has *not* been created by (or only by) a machine – perhaps, for example, it results from a more &ldquo;organic&rdquo; process of development (maybe a Shakespeare play?) – into a form that a machine can &ldquo;recognize&rdquo;, or rather into a form we can recognize in and with the machine, without mishandling it and distorting it. Since machines do not recognize anything (nothing is &ldquo;mishandling&rdquo; to them), what this often reduces to in practice is deciding how to agree on a **representation** for information that any creator and any consumer can recognize and work with, without seeing the information first. In itself this is a formidable challenge.

So documents are called &ldquo;unstructured&rdquo; but they might better be called &ldquo;relatively irregular&rdquo;, meaning not that they have no structure, but that each one is structured in itself, and moreover, likely to be incompatible or not fully compatible with encodings designed to capture other structures.

And to the extent this is the case, any encoding capable of describing documents must have the capability of supporting each document's own distinctive structure and organization, whether that be due to its family (what is called a **document type**) or an expression of its own intrinsic logic. The format must be not only structured, but *structurable*, and its structures must to some extent be capable of self-description – combining data with metadata.

And this is to give no consideration to the fact that these structures can be described at *multiple levels* of generality or specificity with regard to either their supposed semantics, or their configuration in operation.

Documentary data formats, especially declarative markup formats, are designed to work in this in-between space.

And so we get XPath - a query syntax which permits working with an organized structure of a particular kind (an *XDM document tree*), which in turn is designed for handling the combination of *highly regular* and *quite irregular* data structures that characterize information sets we (loosely) call **documentary**.

### XPath illustrative examples

This is not the place to learn XPath, but a selection of XPath expressions can offer a hint of its capabilities.

| XPath | Returns | XPath long (explicit) notation |
| --- | --- | --- |
| `/html` | An XML document root (top-level) element named `html` (subject to namespace resolution) | `/child::html` |
| `//p` | All the elements named `p` in the document | `/descendant-or-self::element()/ child::p` |
| `//seg[@type='null']` | All the elements named `seg` with an attribute `type` with value `null` | `/descendant-or-self::element()/ child::seg[attribute::type='null']` |
| `/*` | Any document (rather, any element at the top of a document) - `*` is a wildcard character | `/child::element()` |
| `/section[exists(.//table)]` | An element inside the top-level element, named `section`, that contains a `table` element anywhere inside it | `/child::section[exists(self::node()/ descendant-or-self::element()/ child::table)]` |
| `/descendant::p[10]` | The tenth `p` element in the document | `/descendant::p[position() eq 10]` |
| `//p[10]` | All `p` elements, that are the tenth `p` inside their respective parents | `/descendant-or-self::element()/ child::p[position() eq 10]` |
| `//section[count(.//p) gt 10]` | All `section` elements that contain more than 10 `p` elements, at any depth | `/child::section[count(self::node()/ descendant-or-self::element()/ child::p) gt 10]` |

Where do you find XPath? Any `select` or `match` expression in XSLT or XProc shows an example. XPath also constitutes the core of XQuery.

## Exercise: Discussion board

Create or contribute to a Github discussion board offering perspective or (especially!) relevant information or experience on any of the larger questions.
