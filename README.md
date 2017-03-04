# Depreciated!

Newer versions of the [rqrcode](https://github.com/whomwah/rqrcode) gem have native svg output, rendering this obsolete.


## RQRCode to SVG

Generate QR Codes as vector graphics. This package adds a `to_svg` method to the excellent [rqrcode](https://github.com/whomwah/rqrcode) gem. It's pure Ruby, with no outside dependencies on heavier image manipulation or XML tools like RMagick or Nokogiri.

### Installation

```ruby
gem install rqrcode_to_svg
```

### Usage

Start by creating an `RQRCode::QRCode` object as supplied by `rqrcode`.

```ruby
qr = RQRCode::QRCode.new("http://www.google.com", :size => 4, :level => 'h')
```

An SVG is just one step away.

```ruby
qr.to_svg
```

Without any options, this will return a string of the SVG's XML.

But there are many options.

```ruby
qr.to_svg(:file => 'test.svg', :px => 4, :border => true, :namespace => false, :indent => false)
```

* `:file` will write the SVG out to a file and return the path.
* `:px` increases the size of each code-point by the given number of pixels-per-side-of-the-square. Defaults to `4`.
* `:border` toggles the border around the QR code. Defaults to `false`.
* `:namespace` toggles use of the XML namespace prefix within the SVG. Defaults to `false`.
* `:indent` toggles the pretty printing of the SVG's internal XML. Defaults to tag soup at `false`.

All options optional. Check out the documentation within the code for additional tweaks.
