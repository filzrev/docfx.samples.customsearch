# Config Reference

The `docfx.json` file indicates that the directory is the root of a docfx project.

```json
{
  "build": { },
  "metadata": { },
  "pdf": { }
}
```

## Global properties 

### `rules`

Overrides default log message severity level. Key is the log code, supported values are `verbose`, `info`, `suggestion`, `warning`, `error`:

```json
{
  "rules": {
    "InvalidHref": "info"
  }
}
```

## `build`

Configuration options that are applied for `docfx build` command:

```json
{
  "build": {
    "content": ["**/*.{md|yml}"],
    "resource": ["**/media/**"],
    "globalMetadata": {
      "_appTitle": "My App"
    }
  }
}
```

### `content`

Specifies an array of content files to include in the project. Supports [File Mappings](#file-mappings)

```json
{
  "build": {
    "content": ["**/*.{md,yml}"]
  }
}
```

### `resource`

Specifies an array of resource files to include in the project. Supports [File Mappings](#file-mappings).

```json
{
  "build": {
    "resource": ["**/*.png"]
  }
}
```

### `overwrite`

Contains all the conceptual files that contain yaml headers with `uid` values and is intended to override the existing metadata `yml` files. Supports [File Mappings](#file-mappings).

### `globalMetadata`

Contains metadata that will be applied to every file, in key-value pair format. For example, you can define `"_appTitle": "This is the title"` in this section, and when applying template `default`, it will be part of the page title as defined in the template.

```json
{
  "build": {
    "globalMetadata": {
      "_appTitle": "DocFX website",
      "_enableSearch": "true"
    }
  }
}
```

See [Predefined Metadata](#predefined-metadata) section for a list of predefined metadata.

### `fileMetadata`

Specifies metadata associated with a particular file in order of metadata name, file [glob patterns](#glob-patterns) and metadata value:

```json
{
  "build": {
    "fileMetadata": {
        "priority": {
            "**.md": 2.5,
            "spec/**.md": 3
        },
        "keywords": {
            "obj/docfx/**": ["API", "Reference"],
            "spec/**.md": ["Spec", "Conceptual"]
        },
        "_noindex": {
            "articles/**/article.md": true
        }
    }
  }
}
```

See [Predefined Metadata](#predefined-metadata) section for a list of predefined metadata.

### `globalMetadataFiles`

Set [`globalMetadata`](#globalmetadata) from external files.

```json
{
  "build": {
    "globalMetadataFiles":  ["global1.json", "global2.json"]
  }
}
```

### `fileMetadataFiles`

Set [`fileMetadata`](#filemetadata) from external files.

```json
{
  "build": {
    "fileMetadataFiles": ["file1.json", "file2.json"],
  }
}
```

### `template`

The templates applied to each file in the documentation. Specify a string or an array. The latter ones will override the former ones if the name of the file inside the template collides. If omitted, the embedded `default` template will be used.

Templates are used to transform YAML files generated by `docfx` to human-readable pages. A page can be a markdown file, an html file or a plain text file. Each YAML file will be transformed to one page and be exported to the output folder preserving its relative path to `src`. For example, if pages are in HTML format, a static website will be generated in the output folder.

```json
{
  "build": {
    "template": "custom",
  }
}
```
```json
{
  "build": {
    "template": ["default", "my-custom-template"],
  }
}
```

> [!NOTE]
> Docfx provides several builtin has embedded templates: `default`, `default(zh-cn)`, `statictoc` and `common`.
> Please avoid using these as template folder name.

### `theme`

The themes applied to the documentation. Theme is used to customize the styles generated by `template`. It can be a string or an array. The latter ones will override the former ones if the name of the file inside the template collides. If omitted, no theme will be applied, the default theme inside the template will be used.

Theme is to provide general styles for all the generated pages. Files inside a theme will be generally copied to the output folder. A typical usage is, after YAML files are transformed to HTML pages, well-designed CSS style files in a Theme can then overwrite the default styles defined in template, e.g. `main.css`.


### `xref`

Specifies the urls of xrefmap used by content files. Currently, it supports following scheme: http, https, file.

### `exportRawModel`

If set to true, data model to run template script will be extracted in `.raw.json` extension.

### `rawModelOutputFolder`

Specifies the output folder for the raw model. If not set, the raw model will appear in the same folder as the output documentation.

### `exportViewModel`

If set to true, data model to apply template will be extracted in `.view.json` extension.

### `viewModelOutputFolder`

Specifies the output folder for the view model. If not set, the view model will appear in the same folder as the output documentation.

### `dryRun`

If set to true, the template will not be applied to the documents. This option is always used with `--exportRawModel` or `--exportViewModel` so that only raw model files or view model files will be generated.

### `maxParallelism`

Sets the max parallelism. Setting 0 (default) is the same as setting to the count of CPU cores.

### `markdownEngineProperties`

Sets the parameters for the markdown engine, value is a JSON object.

### `sitemap`

Specifies the options for generating [sitemap.xml](https://www.sitemaps.org/protocol.html) file:

```json
{
  "build": {
    "sitemap":{
        "baseUrl": "https://dotnet.github.io/docfx",
        "priority": 0.1,
        "changefreq": "monthly",
        "fileOptions":{
            "**/api/**.yml": {
                "priority": 0.3,
                "lastmod": "2001-01-01",
            },
            "**/GettingStarted.md": {
                "baseUrl": "https://dotnet.github.io/docfx/conceptual",
                "priority": 0.8,
                "changefreq": "daily"
            }
        }
    }
  }
}
```

Generated sitemap.xml:

```xml
<?xml version="1.0" encoding="utf-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://dotnet.github.io/docfx/api/System.String.html</loc>
    <lastmod>2001-01-01T00:00:00.00+08:00</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.3</priority>
  </url>
  <url>
    <loc>https://dotnet.github.io/docfx/conceptual/GettingStarted.html</loc>
    <lastmod>2017-09-21T10:00:00.00+08:00</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.3</priority>
  </url>
  <url>
    <loc>https://dotnet.github.io/docfx/ReadMe.html</loc>
    <lastmod>2017-09-21T10:00:00.00+08:00</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.1</priority>
  </url>
</urlset>
```

#### `baseUrl`

Specifies the base url for the website to be published. It MUST begin with the protocol (such as http) and end with a trailing slash. For example, `https://dotnet.github.io/docfx/`. If the value is not specified, sitemap.xml will NOT be generated.

#### `lastmod`

Specifies the date of last modification of the file. If not specified, docfx automatically set the value to the time the file is built.

#### `changefreq`

Specifies the value of [changefreq](https://www.sitemaps.org/protocol.html#changefreqdef) in sitemap.xml. Valid values are `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, `never`. If not specified, the default value is `daily`

#### `priority`

Specifies the value of [priority](https://www.sitemaps.org/protocol.html#prioritydef) in sitemap.xml. Valid values between `0.0` and `1.0`. If not specified, the default value is `0.5`

#### `fileOptions`

This property can be used when some specific files have different sitemap settings. It is a set of key-value pairs, where key is the [*glob* pattern](#23-glob-pattern) for input files, and value is the sitemap options. Order matters and the latter matching option overwrites the former ones.

### `disableGitFeatures`

Disable fetching Git related information for articles. Set to `true` if fetching Git related information is slow for huge Git repositories. Default value is `false`.

## `metadata`

Configuration options that are applied for `docfx metadata` command:

```json
{
  "metadata": [
    {
      "src": [
        {
          "files": ["**/*.csproj"],
          "exclude": [ "**/bin/**", "**/obj/**" ],
          "src": "../src"
        }
      ],
      "dest": "api"
    }
  ]
}
```

### `src`

Specifies the source projects using [File Mappings](#file-mappings).

### `output`

Specifies the output folder of the generated metadata files relative to `docfx.json` directory. The `docfx metadata --output <outdir>` command line argument overrides this value.

### `outputFormat`

Specifies the generated output file format.

- `mref` (default): output as ManagedReference YAML files.
- `markdown`: Output as common-mark compliant markdown file.

### `dest`

Specifies the output folder of the generated metadata files relative to `docfx.json` directory.  The `docfx metadata --output <outdir>` command line argument prepends this value.

### `shouldSkipMarkup`

If set to true, DocFX would not render triple-slash-comments in source code as markdown.

### `filter`

Specifies the filter configuration file, please go to [How to filter out unwanted apis attributes](../tutorial/howto_filter_out_unwanted_apis_attributes.md) for more details.

### `disableDefaultFilter`

Disables the default filter configuration file.

### `disableGitFeatures`

Disables generation of view source links.

### `properties`

Specifies an optional set of MSBuild properties used when interpreting project files. These are the same properties that are passed to msbuild via the `/property:name=value` command line argument.

```json
{
  "metadata": [
    {
      "properties": {
          "TargetFramework": "netstandard2.0"
      }
    }
  ]
}
```
> [!Note]
> Make sure to specify `"TargetFramework": <one of the frameworks>` in your docfx.json when the project is targeting for multiple platforms.

### `noRestore`

Do not run `dotnet restore` before building the projects.

### `namespaceLayout`

Specifies how namespaces in TOC are organized:

- `flattened` (default): Renders namespaces as a single flat list.
- `nested`: Renders namespaces in a nested tree form.

### `memberLayout`

Specifies how member pages are organized:

- `samePage` (default): Places members in the same page as their containing type.
- `separatePages`: Places members in separate pages.

### `allowCompilationErrors`

When enabled, continues documentation generation in case of compilation errors.

### `EnumSortOrder`

Specifies how enum members are sorted:

- `alphabetic` (default): Sort enum members in alphabetic order.
- `declaringOrder`: Sort enum members in the order as they are declared in the source code.

### `includePrivateMembers`

Specifies whether private or internal APIs are included in the generated docs. The default value is `false`.

### `includeExplicitInterfaceImplementations`

Specifies whether explicit interface implementations are included in the generated docs. The default value is `false`.

## File Mappings

In the short-hand form, these filenames are resolved relative to the directory containing the `docfx.json` file:

```json
{
  "build": {
    "content": ["**/*.md", "TOC.yml"]
  }
}
```

In the expanded form, the `files` are resolved relative to `src` directory, or the directory containing the `docfx.json` file in absence of the `src` property:

```json
{
  "build": {
    "content": [
      {"files": "docs/**/*.md", "dest": "docs"},
      {"files": ["**/*.yml", "*.md"], "exclude": ["**/*Private*"], "src": "../api", "dest": "api" }
    ]
  }
}
```

### `files`

The file or file array, supports [glob patterns](#glob-patterns).

### `exclude`

The files to be excluded, supports [glob patterns](#glob-patterns).

### `src`

Specifies the source directory relative to the `docfx.json` directory, supports relative directory outside of the `docfx.json` directory such as `..`.

### `dest`

The folder name for the generated files.

### Glob Patterns

- `*`: Matches 0 or more charactors in a single path portion.
- `?`: Matches 1 character in a signle path portion.
- `**`: Matches 0 or more directories and subdirectories.
- `{}`: Expands the comma-delimited sections within the braces into a set.

## Predefined Metadata

These are the standard metadata predefined by docfx. They are supported by builtin templates and SHOULD be supported by 3rd-party templates:

### `_appTitle`

A string suffix appended to the title of every page.

### `_appName`

The name of the site displayed after the logo.

### `_appFooter`

The footer text. Shows Docfx's Copyright text if not specified.

### `_appLogoPath`

Logo file's path from output root. Will show DocFX's logo if not specified. Remember to add file to resource.

### `_appFaviconPath`

Favicon file's path from output root. Will show DocFX's favicon if not specified. Remember to add file to resource.

### `_enableSearch`

Indicate whether to show the search box on the top of page.

### `_enableNewTab`

Indicate whether to open a new tab when clicking an external link. (internal link always shows within the current tab)

### `_disableNavbar`

Indicate whether to show the navigation bar on the top of page.

### `_disableBreadcrumb`

Indicate whether to show breadcrumb on the top of page.

### `_disableToc`

Indicate whether to show table of contents on the left of page.

### `_disableAffix`

Indicate whether to show the affix bar on the right of page.

### `_disableContribution`

Indicate whether to show the `View Source` and `Improve this Doc` buttons.

### `_gitContribute`

Customize the `Improve this Doc` URL button for public contributors. Use `repo` to specify the contribution repository URL. Use `branch` to specify the contribution branch. Use `apiSpecFolder` to specify the folder for new overwrite files. If not set, the git URL and branch of the current git repository will be used.

### `_gitUrlPattern`

Choose the URL pattern of the generated link for `View Source` and `Improve this Doc`. Supports `github` and `vso` currently. If not set, DocFX will try speculating the pattern from domain name of the git URL.

### `_noindex`

File(s) specified are not returned in search results
