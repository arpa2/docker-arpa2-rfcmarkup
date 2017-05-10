# Docker Image for ARPA2 rfcmarkup

> *Ever waded through lists of RFCs looking for the definition of an
> ASN.1 type?  No more, rfcmarkup has done it for you, and presented
> it as a simple hyperlink.*

This docker image is based on the
[ARPA2 Base](https://github.com/arpa2/docker-arpa2-base)
and hosts the RFC series, which it presents as HTML files.

When it encounters ASN.1 code, it will parse their type definitions
and make them targets of references.  Then it will add links to these
definitions from all occurrences in the text and formal definitions
of which it assumes that they reference an ASN.1 type.

To make it all really nice, rfcmarkup also parses the table of
references, and makes sure to know about its defined types as well.
It will insert links to those ASN.1 types in referenced documents
too.

## Running the Docker Image

Assuming you have built `arpa2:base` followed by `arpa2:rfcmarkup`
you can run

    docker run \
               -p 127.0.0.1:7059:7059 \
               -v ~/Documents/ietf.org:/var/www/ietf.org arpa2:rfcmarkup

This will expose port 7059 on localhost, and use your local filesystem
as an RFC cache, in this case the ASCII files and our own `.idx` files
end up in `~/Documents/ietf.org/rfc` and will be kept up to date on a
daily basis.

## Plenty to Improve...

This is a snapshot of a working version.  It is not up to date with the
most recent official release of
[rfcmarkup](https://tools.ietf.org/tools/rfcmarkup/)
simply because it does/did not have a visible versioning system to
fork off of.  This is also the only reason why these changes have not
been offered back to the tool authors.

We might setup (a better) tool to automatically update the textual
RFC directory.

We might setup caching, so we can serve specifications much faster.

We might use Etag headers to instruct browsers that they can trust
their web caches and simply look for a referenced anchor in the
cached file.

We might add personal annotation services, perhaps based on localStorage.
This could include keywords and tags, as well as annotations and
side references to other RFCs.

If you feel like adding, then please have a ball!

The volume `/var/www/ietf.org` is exported, and it is probably good to
link it to a local directory.  That way, we can access the text literally,
for instance with `grep`, and we have a place where updates are stored
so a restart of the container does not always have to bother IETF for the
same reloads.
