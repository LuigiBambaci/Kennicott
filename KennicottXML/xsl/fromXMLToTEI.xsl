<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
    <xsl:strip-space elements="*"/>


    <xsl:template name="rdgGenerator">
        <xsl:element name="rdg">
            <xsl:attribute name="wit">
                <xsl:for-each select="descendant-or-self::sigl">
                    <xsl:text>#K</xsl:text>
                    <xsl:value-of select="replace(., ' |\n', '')"/>
                    <xsl:if test="position() != last()">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="start">
        <xsl:processing-instruction name="xml-model">
            href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"
        </xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">
            href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"
        </xsl:processing-instruction>

        <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="teiHeader">
                <xsl:element name="fileDesc">
                    <xsl:element name="titleStmt">
                        <xsl:element name="title">Title</xsl:element>
                    </xsl:element>
                    <xsl:element name="publicationStmt">
                        <xsl:element name="p">Publication Information</xsl:element>
                    </xsl:element>
                    <xsl:element name="sourceDesc">
                        <!--<xsl:element name="p">Information about the source</xsl:element>-->
                        <xsl:element name="listWit">
                            <xsl:for-each select=" distinct-values(//sigl)">
                                <xsl:sort data-type="number"/>
                                <xsl:element name="witness">
                                    <xsl:attribute name="xml:id">
                                        <xsl:text>K</xsl:text>
                                        <xsl:value-of select="replace(normalize-space(.), ' ', '')"/>
                                    </xsl:attribute>
                                    <xsl:text>K</xsl:text>
                                    <xsl:value-of select="replace(normalize-space(.), ' ', '')"/>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="text">
                <xsl:element name="body">
                    <xsl:element name="div">
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="listApp">
        <xsl:element name="listApp">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="app">
        <xsl:element name="app">
            <xsl:attribute name="loc">
                <xsl:value-of select="replace(ancestor-or-self::listApp/descendant-or-self::chap/num, ' |\n', '')"/>
                <xsl:text> </xsl:text>
                <xsl:for-each select="ancestor-or-self::listApp/descendant-or-self::verse/num">
                    <xsl:value-of select="normalize-space(.)"/>
                    <xsl:if test="position() != last()">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>

            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="lem">
        <xsl:element name="lem">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="num">
        <xsl:element name="num">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="rasura">
        <xsl:element name="metamark">
            <xsl:attribute name="function">eras</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="numSign">
        <xsl:element name="pc">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="rdgGrp">
        <xsl:element name="rdgGrp">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="noteApp">
        <xsl:element name="rdg">
            <xsl:element name="note">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="rdg">
        <xsl:choose>
            <!-- se la rdg è singularis, la stampo -->
            <xsl:when test="count(descendant-or-self::wit) = 1">
                <xsl:call-template name="rdgGenerator"/>
            </xsl:when>
            <!-- se la rdg non è singularis ma non ci sono nè note di kq nè rdg marginali, la stampo -->
            <xsl:when test="count(descendant-or-self::wit) > 1 and (not(descendant-or-self::marg) and not(descendant-or-self::kq))">
                <xsl:call-template name="rdgGenerator"/>
            </xsl:when>
            <xsl:when test="count(descendant-or-self::wit) > 1 and (descendant-or-self::marg or descendant-or-self::kq)">
                <!-- se ci sono note di kq o rdg marginali genero delle rdg per ciascun testimone -->
                <xsl:element name="rdg">
                    <xsl:attribute name="wit">
                        <!-- metto nel wit di rdg tutti i testimoni che non hanno note di kq o rdg marginali -->
                        <xsl:for-each
                            select="descendant-or-self::sigl[not(ancestor-or-self::wit[descendant-or-self::marg or descendant-or-self::kq])]">
                            <xsl:text>#K</xsl:text>
                            <xsl:value-of select="replace(., ' |\n', '')"/>
                            <xsl:if test="position() != last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <!-- se ci sono note di kq o rdg marginali metto i testimoni in tante rdg separate -->
                <xsl:for-each select="descendant-or-self::sigl[ancestor-or-self::wit[descendant-or-self::marg or descendant-or-self::kq]]">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">
                            <xsl:for-each select=".">
                                <xsl:text>#K</xsl:text>
                                <xsl:value-of select="replace(., ' |\n', '')"/>
                            </xsl:for-each>
                        </xsl:attribute>
                        <!-- rdg marginali -->
                        <xsl:if test="ancestor-or-self::wit[descendant-or-self::marg]">
                            <xsl:element name="term">
                                <xsl:value-of select="normalize-space(ancestor-or-self::wit/marg)"/>
                            </xsl:element>
                        </xsl:if>
                        <!-- note di kq -->
                        <xsl:if test="ancestor-or-self::wit[descendant-or-self::kq]">
                            <xsl:for-each select="ancestor-or-self::wit/descendant-or-self::kq/*">
                                <xsl:variable name="nameNode" select="name(.)"/>
                                <xsl:choose>
                                    <xsl:when test="$nameNode = 'kqWord'">
                                        <xsl:element name="w">
                                            <xsl:value-of select="normalize-space(.[$nameNode = 'kqWord'])"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:when test="$nameNode = 'lin'">
                                        <xsl:element name="metamark">
                                            <xsl:attribute name="function">abbr</xsl:attribute>
                                            <xsl:value-of select="normalize-space(.[$nameNode = 'lin'])"/>
                                        </xsl:element>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:element>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="w">

        <xsl:choose>
            <xsl:when test="not(*)">
                <xsl:element name="w">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="w">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="term">
        <xsl:element name="term">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="range">
        <xsl:element name="metamark">
            <xsl:attribute name="function">range</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="et">
        <!-- ci sono due tipi di et: uno (raro) usato nelle rdg, per esempio: ל et ם sup. ras.; 
        un altro usato nel lemma per le occorrenze, per esempio: 1° et 2°
        Li inserisco tutti e due dentro elementi <w>, ma sono comunque distinguibili perchè uno è discendente di w e l'altro di occ-->
        <xsl:choose>
            <xsl:when test="ancestor-or-self::w">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="ancestor-or-self::occ">
                <xsl:element name="w">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="marg">
        <!-- questo template serve per stampare le note marginali se la rdg è singularis, altrimenti serve il template rdg di sopra -->
        <xsl:choose>
            <xsl:when test="ancestor-or-self::rdg[descendant-or-self::wits[count(descendant-or-self::wit) = 1]]">
                <xsl:element name="term">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="kq/*">
        <!-- questo template serve per stampare le note di kq se la rdg è singularis, altrimenti serve il template rdg di sopra -->
        <xsl:choose>
            <xsl:when test="ancestor-or-self::wits[count(descendant-or-self::wit) = 1]">
                <xsl:variable name="nameNode" select="name(.)"/>
                <xsl:choose>
                    <xsl:when test="$nameNode = 'kqWord'">
                        <xsl:element name="w">
                            <xsl:value-of select="normalize-space(.[$nameNode = 'kqWord'])"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="$nameNode = 'lin'">
                        <xsl:element name="metamark">
                            <xsl:attribute name="function">abbr</xsl:attribute>
                            <xsl:value-of select="normalize-space(.[$nameNode = 'lin'])"/>
                        </xsl:element>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="noteMarg">
        <xsl:element name="note">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="lin">
        <xsl:element name="metamark">
            <xsl:attribute name="function">abbr</xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:element>
    </xsl:template>





    <!-- GARBAGE COLLECTOR -->
    <xsl:template match="loc"/>
    <!--<xsl:template match="wit"/>-->
    <xsl:template match="sigl"/>
    <xsl:template match="com"/>
    <xsl:template match="closeLoc"/>
    <xsl:template match="closeApp"/>
    <xsl:template match="rdgGrpSep"/>
    <xsl:template match="rdgSep"/>
    <xsl:template match="lemSep"/>
    <xsl:template match="EOF"/>


</xsl:stylesheet>
