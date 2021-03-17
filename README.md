# Kennicott

## KennicottXML

KennicottXML is a project dedicated to the encoding of Benjamin Kennicott's apparatus in [XML-TEI language](https://tei-c.org/). 
The encoding is carried out automatically by means of a parser, created using [ANTLR4 software](https://www.antlr.org/).
Below is the list of folders and their contents.

- **cfg**: contains the context-free grammar (CFG) used by ANTLR4 for parsing the apparatus

- **tei**: contains the final list of XML files according to the TEI international standard

- **txt**: contains the digitized apparatus of the individual books of the Hebrew Bible in TXT format

- **xml**: contains the xml files resulting from parsing

- **xsl**: contains the XSL-T stylesheet needed to transform the XML code into TEI
