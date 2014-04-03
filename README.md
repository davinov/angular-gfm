# angular-gfm
GitHub Flavored Markdown rendering in angular apps

## Installation
`bower install my-way.angular-gfm`

## Usage
Include `mw.angular-gfm-tpls.js` and optionnally `angular-gfm.css` (works with bootstrap), then require `mw.angular-gfm` in your angular app.
These directives can be used as class, attribute or element.

```html
<div github-readme></div>
<div class='github-readme'></div>
<github-readme></github-readme>
````

> The last one is not IE8 compatible

### Usage with less
Import `dist/less/angular-gfm.less` in your less main file.

## Options
Option  | Type  | Description
------  | ----  | -----------
repo    | string| [user/org]/[repo-name]
show-title| bool  | show or hide panel title

## Example
See docs/angular-gfm.html (require `bower install`)

## Build the package
`npm install` and `npm run build`
