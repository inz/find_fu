# Find Fu

An extension for the [Radiant CMS](http://radiantcms.org), adding some advanced find methods.

## Tags

Currently this extension adds the following tags for you to peruse:

### children:new

> `<r:children:new>...</r:children:new>`

Returns children to be published **after** a specified date (defaults to today).

The date can be specified using the **`from`** parameter.

The following example will list all articles that have been published within the last 30 days:

    <r:find url="/articles">
      <r:children:new from="30.days.ago">
        ...
      </r:children:new>
    </r:find>

### children:old

> `<r:children:old>...</r:children:old>`

Returns children to be published **before** a specified date (defaults to today).

The date can be specified using the **`to`** parameter.

### General Remarks

 * `r:children:new` as well as `r:children:old` support all regular options you can pass to `r:children[:...]`.
 * the `from` and `to` attributes are evaluated as pure ruby code, which could potentially be a **major security risk**! You have been warned! (Feel free to suggest alternatives though)

### if\_url\_with\_match

> `<r:if_url_with_match matches="regexp">...</r:if_url_with_match>`

Does the same as `<r:if_url>` except that every back-reference (as well as the whole matched string) you define in your regular expression will be accessible within the tag using `<r:match />`.

### match

> `<r:match [id="1"] />`

Can be used within `r:if_url_with_match` to retrieve the value of any backreference defined in the regular expression.

    <r:if_url_with_match matches="^/([^/])/.*$">
      You're currently in the <r:match /> directory!
    </r:if_url_with_match>

## Installation

The extension is tested against 0.6.5, it should work for other versions though.

To install the extension just run

    git clone git://github.com/inz/find_fu.git vendor/extensions/find_fu

and (re)start your radiant installation.

Of course you can also include the extension as a git submodule like so:

    git submodule add git://github.com/inz/find_fu.git vendor/extensions/find_fu
    
Enjoy!