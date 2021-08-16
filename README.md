# JSON Encoder

This is a tool that will encode an arbitrary JSON document into a compact form that can be stored inside of a QR code.

## Example

The following JSON document:

```
{
  "string": "abc",
  "object":
  {
    "integer": 1
  },
  "array": [1, 2, 3]
}
```

Encodes to this string:

```
STRING.ABC.OBJECT.*INTEGER.1+.ARRAY.-1.2.3
```

View the unit tests for more complex examples.

## Usage

```
require "json_encoder"
example = {test: [1, 2.2, {three: [4, 5.5, "six"]}]}

encoded = JsonEncoder.encode(example)
# => "TEST.-1.2$.2.*THREE.-4.5$.5.SIX"

decoded = JsonEncoder.decode(encoded)
decoded == example # => true

example.to_json.length # => 40
encoded.length         # => 31
```

## Concept

This is an alternative implementation of the format described by [this](https://www.blackpepper.co.uk/blog/theres-plenty-of-room-at-the-bottom-nfc) blog post. To paraphrase the relevant parts:

> A JSON object really just describes a tree of data. But JSON's formatting, whilst it's nice and readable, takes up quite a bit of space. Instead, we can replace the JSON format with something smaller. Imagine you're a robot, walking that tree of data. To visit the whole thing, you will do each of four things:
>
> - Go down into an object sub-tree
> - Go down into an array sub-tree
> - Move sideways, from one branch to the one next to it, or
> - Move back up a branch to its parent.
>
> We represent each of these four movements by the symbols `*-+.` respectively.
> In addition, we prefix each of the uppercase letters with some symbol, say the `$` symbol, then uppercase the whole string.

It uses the Alphanumeric alphabet of the QR specification for reducing the total size of the QR code by utilizing the symbols `$*-+.` for the JSON structure, and percent-encoding all other symbols. `$*-+.` were selected as a subset of the [Safe85](https://github.com/kstenerud/safe-encoding/blob/master/safe85-specification.md) specification, chosen to remain compliant with generic URIs. `:` is specifically reserved as a separator between the JSON document and some other data, such as a [Base41]()-encoded signature.

## Symbol table

The `$` is used as an escape character, to be read as "shift". All letters are encoded in uppercase, but decoded as lowercase. Any letter preceded by a `$` is decoded as uppercase.

For example, `Hello World` encodes to `$HELLO $WORLD`.

Symbols that are commonly used in QR codes are assigned a "shift" value, as the resulting 2 characters is shorter than the 3 characters obtained by percent-encoding.

Below are the symbols and what they encode to:

```
{
  "$" => "$$",
  "*" => "$*",
  "-" => "$-",
  "+" => "$+",
  "." => "$.",
  "#" => "$0",
  "&" => "$1",
  "," => "$2",
  "/" => "$3",
  ":" => "$4",
  ";" => "$5",
  "=" => "$6",
  "?" => "$7",
  "@" => "$8",
  "_" => "$9",
}
```

## Optimizations

The JSON document is sorted by "depth"; deeper nestings of objects and arrays are pushed to the back. This is because any `+` at the end of the encoding can be stripped off, as they are implied. This restructuring can save a few characters.

In addition, if the encoded string does not begin with `-`, it is assumed that the encoding represents an object, allowing any preceeding `*` to be stripped. If during decoding, it is found that the object doesn't have both a key and a value, then it is interpreted as a string instead.

## Caveats

All type information is lost during encoding, and instead values are interpreted as strings. Strings are then "cast" back to their implicit types. This means that the string "123" will not round-trip back to a string; it will be cast to an integer.

## References

- https://www.blackpepper.co.uk/blog/theres-plenty-of-room-at-the-bottom-nfc
- https://practicingruby.com/articles/parsing-json-the-hard-way?u=90296723ac
- https://github.com/tenderlove/rjson
- https://github.com/kstenerud/safe-encoding
- https://github.com/Path-Check/paper-cred
- https://gir.st/blog/greenpass.html
- https://news.ycombinator.com/item?id=27603173