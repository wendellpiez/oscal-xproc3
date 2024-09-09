> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/unpack/unpack_101_src.html](../../../tutorial/source/unpack/unpack_101_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 101: Unpacking XProc 3.0



## Goals

* More familiarity with XProc 3.0: some syntax
* History, concepts and resources


## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101.md).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../projects/xproc-doc/readme.md)

## Prerequisites

Same as [Setup 101](../setup/setup_101.md).

## A closer look

If you have completed [Setup 102](../setup/setup_101.md) you have already glanced at the [lib](../../../lib/readme.md) and [smoketest](../../../smoketest/readme.md) folders, and run pipelines you have found therein. To edit these files, use any XML-capable plain text editor (that is, with care, any editor at all that save text files as UTF-8).

Routine code inspection can also be done on Github as well (not a bad idea in any case), not just in a copy.

A quick summary of what these pipelines do:

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl) downloads a zip file from a [Saxonica download site](https://www.saxonica.com/download), saves it, and extracts a `jar` (Java library) file, which it places in the Morgana library directory
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl) downloads a zip file from Github and unzips it into a directory where Morgana can find it.
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl) also downloads and &ldquo;unarchives&rdquo; a zip file resource, this time a copy of [an XSpec
               distribution](https://github.com/xspec/xspec).


Essentially, these all replicate and capture the work a developer must do to identify and acquire libraries. Maintaining our dependencies this way - not quite, but almost &ldquo;by hand&rdquo;, -- appears to have benefits for system transparency and robustness.

The second group of pipelines is a bit more interesting. Each of the utilities provided for in packages just downloaded is tested by running a smoke test.

Each smoke test performs a minor task, serving as a &ldquo;smoke test&rdquo; inasmuch as its only aim is to determine whether a simple representative process completes successfully. (When we plug in the board, can we see and smell smoke?)

* [smoketest/POWER-UP.xpl](../../../smoketest/POWER-UP.xpl) amounts to an XProc &ldquo;Hello World&rdquo;. In that spirit, feel free to edit and adjust this file.
* [smoketest/SMOKETEST-XSLT.xpl](../../../smoketest/SMOKETEST-XSLT.xpl) tests Saxon, an XSLT/XQuery transformation engine. XSLT and XQuery are related technologies (different languages, same data model) developed with XML processing in mind, but in recent years generalized to a wider range of data structures.
* [smoketest/SMOKETEST-SCHEMATRON.xpl](../../../smoketest/SMOKETEST-SCHEMATRON.xpl) tests SchXSLT. SchXSLT is an implementation of Schematron, an ISO-standard validation and reporting technology. Schematron relies on XSLT, so this library requires Saxon.
* [smoketest/SMOKETEST-XSPEC.xpl](../../../smoketest/SMOKETEST-XSPEC.xpl) tests XSpec, an XSLT-based testing framework useful for testing deployments of XSLT, XQuery and Schematron.


All these together comprise more than can be learned in an afternoon, or even a week. Any and each of them can nonetheless be used as a &ldquo;black box&rdquo; by any competent operator, even without understanding about internals.

At the same time, common foundations make it possible to learn these technologies together and in tandem.

In particular, they all share a syntax for interrogating (querying) the structure of an XML document and returning its data: the XPath expression language.

## Messing around

Taking some time to make and test small adjustments to working code is a great way to develop a sense of how it behaves.

An easy way to do this without perturbing the working code in the repository is to copy a pipeline and modify the copy. Modifying one of the smoketest pipelines, see what happens when:

* An `href` points to a location on the system where there is no file
* A file is there, but it is not what is expected (for example: XML is expected but the file is not well formed)
* Individual steps are excluded
* New elements are renamed (etc.)


When changes introduce errors, runtime failures and tracebacks will *sometimes* appear. The indicated problem or the source of the reported problem must be repaired. And sometimes a process will run successfully. Whether it is in error then depends on how well it conforms to its requirements. Does it deliver the results we want and expect?

As an exercise, make some changes in copies of the test pipelines. Make at least one change that produces outputs (such as echoing a document to the console) that are visibly different from the results of the original pipeline.

## XProc coverage index

While they are sometimes rudimentary, the pipelines in this repository address realistic requirements, and as such, offer examples of XProc usage.

A pipeline can process the XProc files in the projects and report where and how they use XProc. [An available prototype](../../PRODUCE-TUTORIAL-ELEMENTLIST.xpl) does this in two forms:

* Assuming the projects are sequenced with the lessons that discuss them, the pipeline gives a listing of *first appearances* of XProc elements among the examples
* With this, it gives a comprehensive index of XProc elements by name, appearing in the projects covered by the lessons


The Markdown results are written to the file [](../../sequence/element-directory.md). It can be refreshed by running [the pipeline](../../PRODUCE-TUTORIAL-ELEMENTLIST.xpl)again.

## Learning about XProc

This tutorial has a handmade[XProc dashboard page](../../xproc-dashboard.md) with links.

Also, see the official [XProc.org dashboard page](https://xproc.org).

Also, check out XProc index materials (with code snips) produced in this repository: [XProc docs](../../../projects/xproc-doc/readme.md). Produced using XProc, these can be covered in detail in a later lesson unit.

There is [a book, Erik Siegel's XProc 3.0
                  Programmer's Reference](https://xmlpress.net/publications/xproc-3-0/) (2020).