# Kennicott

<h>KennicottXML</h>

KennicottXML is a project dedicated to the digitisation of Benjamin Kennicott's work. In particular, the project focuses on the XML encoding of the critical apparatus. 

The encoding is carried out automatically by means of a parser, created using the ANTLR4 software. 

The work-flow can be described as follows:

1) acquisition of the apparatus text through ocr
2) application of a context-free grammar (cfg) through the tools available in ANTLR4
3) production of xml code through a general exporter
4) transformation of the xml code into the international TEI standard.

1. 

Below is the list of folders and their contents.

cfg: contains the context-free grammar (CFG) used by ANTLR4 for parsing the device

TEI: contains the final list of xml files according to the TEI international standard

txt: contains the digitized apparatus of the individual books of the Hebrew Bible in txt format

xml: contains the xml files resulting from parsing

xsl: contains the XSL-T style sheets needed to transform the xml code into tei


Translated with www.DeepL.com/Translator (free version)
