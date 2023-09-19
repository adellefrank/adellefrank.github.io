<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="deptNumber">
        <xsl:value-of select="(count(system-index-block/system-page) div 2) + 2"/>
    </xsl:variable>

    <xsl:template match="path | name"> </xsl:template>

    <xsl:template match="system-index-block">
        <div class="departments">
            <xsl:for-each select="system-page">
                <xsl:sort select="system-page/display-name"/>
                <xsl:if test="position() &lt; $deptNumber">
                    <xsl:apply-templates select="."/>
                </xsl:if>
                <xsl:if test="position() = $deptNumber">
                    <xsl:apply-templates select="."/>
                </xsl:if>
            </xsl:for-each>
        </div>

        <div class="programs">
            <xsl:for-each select="system-page">
                <xsl:sort select="system-page/display-name"/>
                <xsl:if test="position() &gt; $deptNumber">
                    <xsl:apply-templates select="."/>
                </xsl:if>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="system-page">
        <xsl:choose>
            <xsl:when test="name='index'"/>
            <xsl:otherwise>
                <p>
                    <strong>
                        <xsl:value-of select="display-name"/>
                    </strong>
                    <br/>
                    <a href="{system-data-structure/ContactInfo/InternetWebAddress/UnderGraduate}"
                        target="_blank"> Website </a> | <a href="{path}"> Catalog </a>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
