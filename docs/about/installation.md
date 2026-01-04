# Installation & configuration

LesliView and its dependencies are automatically installed when installing Lesli, however you can use the components with any other rails project by installing the gem and dependencies manually.

## Check installation 

```bash
rake lesli:status
```

**result:**

```text
Lesli
-·-     -·-     -·-     -·-     -·-     -·-     -·-     -·-     

| NAME           | CODE            | VERSION   | BUILD                           
| - - - - - - - -| - - - - - - - - | - - - - - | - - - - - - -
| Lesli          | lesli           | 5.0.22    | 1755006918                      
| ---            |                 |           |                                 
| LesliView      | lesli_view      | 1.0.6     | 1767477530                      
| LesliAssets    | lesli_assets    | 1.0.6     | 1755007848                      
| LesliSystem    | lesli_system    | 1.0.4     | 1754919086                      


Environment: development
```

## Manually installation

You can use LesliView in any rails project by installing the gem and its dependencies

```shell
# Add LesliView gem
bundle add lesli_view
bundle add lesli_assets
```


### Loading assets

LesliView depends on Bulma, trix, remixicons and google icons.


```scss
@use "lesli-css";
@use "lesli-css/sass/vendor/bulma";


// · Vendor
@use "trix/dist/trix.css";


// · Configuration & variables
@use "../settings/variables";


// · LesliView components & elements 
@use "LesliView/lib/lesli_view/components/timeline";
@use "LesliView/lib/lesli_view/components/toolbar";
@use "LesliView/lib/lesli_view/components/header";
@use "LesliView/lib/lesli_view/components/panel";
@use "LesliView/lib/lesli_view/components/tabs";
@use "LesliView/lib/lesli_view/elements/avatar";
@use "LesliView/lib/lesli_view/elements/table";
@use "LesliView/lib/lesli_view/forms/form";
@use "LesliView/lib/lesli_view/items/discussions";


// · Font families and icons
@use "../fonts/remixicons";
@use "../fonts/mdsymbols";
@use "../fonts/families";
```
