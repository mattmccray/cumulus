# `loci`

http://github.com/darthapo/loci

## DESCRIPTION:

**Non Functional / Still in Planning Stage**

Here's the high-level (brain dump):

* Site content is organized in collections
* Collections are serialized
* Each have support for next, previous, first, last, etc
* The content files are HTML
* Templates are object based (each content type can be rendered with their own templates)
* Templates are HTML with interspersed Liquid markup
* All meta data is described using HTML meta tags
* You custom meta data tags in a content objects
* You can specify 'prototype' content objects in a collection with a _proto folder in the collection

Oh, and in case you're curious, it's pronounced 'Lo-see'. It's latin:

> loci: (pl.) 
> > Passages in literary works. 

## REQUIREMENTS:

* `hpricot` >= 0.6
* `liquid` >= 1.9

## INSTALL:

    sudo gem install darthapo-loci --source=http://gems.github.com

## LICENSE:

(The MIT License)

Copyright (c) 2008 M@ McCray.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.