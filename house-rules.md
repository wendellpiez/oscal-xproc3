# House Rules 

While not all submissions or contributions will always follow all house rules, any violations can be regarded as fair game for correction.

Developers should always observe and follow the rules.

Assessors should expect them to be followed.

For this site, not all rules are enumerated here. To the extent that aligning rules, rule sets and applications, since that problem is *in scope* for these projects, which may have their own ways of addressing them - so consult project readmes and docs.

Anyone working with XML should know and become familiar with the concept that a rules set - whether in the form of a schema, a transformation or query, or other means of interrogationg and filtering - can always, readily be applied to an XML document. While the significance of the result of such an exam will vary by the case, the *capability* of automating and thereby easily replicating and verifying results by means of an open process, is one whose full implications have not yet been explored..



## Schematron

Schematron for checking XProc pipelines is here: [testing/xproc3-house-rules.sch](testing/xproc3-house-rules.sch).

Please check the [testing](./testing) folder also for Schematrons for other formats including XSpec.

Schematron tests can be applied either interactively, or in CI/CD. Check CI/CD settings.

Additionally, individual projects may provide additional Schematrons enforcing rules and regularities that are considered preconditions for processing there.

PRs supporting any Schematrons are welcome when due diligence has been performed.

## File naming

Check the [.gitignore file](.gitignore) for file names to avoid, including especially XSpec `result` and `report` formats (HTML and XML), which are generated by automated checks and should not ordinarily be committed to the repository.

Project folders may also have their own `.gitignore.` Commonly, files downloaded into a project `lib` may be expected to be excluded as well, for user curation and maintenance.

### File name suffixes

- `*.xpl` is reserved for XProc 3.0

- `*.xproc` is available for XProc 1.0

### All-capitals pipelines

XProc pipelines that function standalone in this repository - with no special runtime arguments - are named with ALL CAPITALS, for example the smoke testing pipeline, [POWER-UP.xpl](smoketest/POWER-UP.xpl). These can be run by simply executing the pipeline.

### Pipelines as steps - subpipelines or pipeline assemblies

XProc pipelines with lower-case names are either subpipelines, or meant to be configured at runtime, or both. Use such pipelines either by providing the extra arguments at runtime; using scripts that do so; or writing 'wrapper' pipelines (which may be self-contained and named in all-upper-case). 


In XProc, a configuration may include any of:

- Bindings for input ports (named per pipeline)
- Settings for runtime parameters or options (ditto)
- Bindings (directives) for output ports (ditto)

Learn more by researching [XProc](https://xproc.org/), looking at examples and trying things out.

<details><summary>More about configuration</summary>

For their data sources, XProc pipelines can either read from the Internet (when connected and authorized), from the local file system under user permissions (more commonly), or from inputs provided at runtime using ports on the pipeline(s) invoked.

Likewise, when run they can either write outputs (into the local file system), or expose results on output ports, or both.

A well-designed pipeline will alert its user as to these activities, effects and state changes, using comments in the code, runtime messaging, and logs as appropriate.

For our pipelines (not repository submodules) we follow a convention that an XProc with *no exposed ports* (no output ports to bind, and no input ports to provide for) is named with ALL CAPITALS. For example, the [smoke-testing pipeline smoketest/POWER-UP.xpl](./smoketest/POWER-UP.xpl). When run, it reports outputs back to the console but does not write anywhere (unless you redirect those outputs to do so).

Such pipelines can be run with no arguments and no prior knowledge of their intended inputs and outputs, since these are all declared in the XProc itself. As processes they are also deterministic, in the sense that hard-wiring them also makes it easy to see, under simple inspection, where they read and write, following the ['rule of least power'](https://en.wikipedia.org/wiki/Rule_of_least_power) and helping the user to do so. Such a pipeline will ordinarily result in outputs to STDOUT (if only status messages) unless configured otherwise at runtime -- but they may and commonly will also write to the file system.

Other XProc pipelines represent either subpipelines, or specialized processing with ports exposed for special purposes, to be called with arguments or parameters as documented. Indeed, the only function of a 'self-contained' ALL-CAPS pipeline may be to apply subpipelines (steps defined in imported XProcs) to hard-wired inputs, producing hard-wired outputs.
</details>