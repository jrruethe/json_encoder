# JSON Encoder

This is a tool that will encode an arbitrary JSON document into a compact form that can be stored inside of a QR code.

It uses the Alphanumeric alphabet of the QR specification for reducing the total size of the QR code by utilizing the symbols ` ` for the JSON structure, and percent-encoding all other symbols. ` ` were selected as a subset of the Safe85 specification, chosen to remain compliant with generic URIs. `:` is specifically reserved as a separator between the JSON document and some other data, such as a Base41-encoded signature.

# Symbol table

- # => $0
- & => $1
- , => $2
- / => $3
- : => $4
- ; => $5
- = => $6
- ? => $7
- @ => $8
- _ => $9

## References

- https://www.blackpepper.co.uk/blog/theres-plenty-of-room-at-the-bottom-nfc
- https://practicingruby.com/articles/parsing-json-the-hard-way?u=90296723ac
- https://github.com/tenderlove/rjson
- https://github.com/kstenerud/safe-encoding
- https://github.com/Path-Check/paper-cred
- https://gir.st/blog/greenpass.html
- https://news.ycombinator.com/item?id=27603173