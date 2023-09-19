<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/system-index-block">     
        <table border="1" cellpadding="5" cellspacing="2" id="peopleDepartment" summary="Directors of Undergraduate Studies, by College Department.">
            <tbody>
                <tr>
                    <th>Department/Program</th>
                    <th>Director of Undergraduate Studies</th>
                </tr>
                <xsl:apply-templates select="system-page"/>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="system-page">
        <xsl:if test="not(name='index') and not(name='languages')">
            <tr>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="path"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="display-name"/>               
                        </xsl:attribute>
                        <xsl:value-of select="display-name"/>
                    </a>
                </td>
                <td>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="system-data-structure/People/Faculty/DirectorUndergraduateStudies/path"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="system-data-structure/People/Faculty/DirectorUndergraduateStudies/display-name"/>               
                        </xsl:attribute>
                        <xsl:value-of select="system-data-structure/People/Faculty/DirectorUndergraduateStudies/display-name"/>
                    </a>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>