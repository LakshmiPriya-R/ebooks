<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
<xsl:template match="/">
<fo:root>
<fo:layout-master-set>
    <fo:simple-page-master master-name="books">
        <fo:region-body margin="1in"/>
    </fo:simple-page-master>
</fo:layout-master-set>

<fo:page-sequence master-reference="books">
    <fo:flow flow-name="xsl-region-body">  
      <fo:block font-size="300%"  margin="10%" font-weight="bold" text-align="center" color="red" ><xsl:value-of select="/books/customtitle"/></fo:block>
      <fo:block font-size="200%"  margin-bottom= "5%" font-weight="bold" >Contents</fo:block>
    <fo:block>
        
        <fo:table table-layout="fixed" width="100%" border-width="20%" border-style="solid">
        <fo:table-column column-width="40%"/>
        <fo:table-column column-width="30%"/>
        <fo:table-column column-width="30%"/>
        <fo:table-header>
        <fo:table-row>
            <fo:table-cell border-width="20%" border-style="solid" padding="1%">
                <fo:block font-weight="bold" font-size="100%">Book</fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="20%" border-style="solid" padding="1%">
                <fo:block font-weight="bold" font-size="100%">Author</fo:block>
            </fo:table-cell>
            <fo:table-cell border-width="20%" border-style="solid" padding="1%">
                <fo:block font-weight="bold" font-size="100%">Price</fo:block>
            </fo:table-cell>    
        </fo:table-row>
        </fo:table-header>
        
        <fo:table-body>
            <xsl:for-each select="/books/book">
            <fo:table-row>
                <fo:table-cell padding="1%" border-width="20%" border-style="solid"><fo:block><xsl:value-of select="name"/></fo:block></fo:table-cell>
                <fo:table-cell padding="1%" border-width="20%" border-style="solid"><fo:block><xsl:value-of select="author"/></fo:block></fo:table-cell>
                <fo:table-cell padding="1%" border-width="20%" border-style="solid"><fo:block><xsl:value-of select="cost"/></fo:block></fo:table-cell>
            </fo:table-row>
            </xsl:for-each>

        </fo:table-body>
        </fo:table>
    </fo:block>
    
    <fo:block font-size="100%"  margin-bottom= "5%" font-weight="bold" >
        <xsl:value-of select="/books/total"/>
    </fo:block>
</fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>