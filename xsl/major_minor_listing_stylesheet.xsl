<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="system-index-block">
        <div class="majorMinor">
            <div id="toc">
                <ul>
                    <li>Declare between the <strong>second semester of the freshman year</strong>
                        and no later than the <strong>end of the sophomore year</strong>.</li>
                    <li>No more than <strong>2 concentrations</strong> allowed, either: <ul>
                            <li>2 majors <strong>OR</strong></li>
                            <li>1 major, 1 minor</li>
                        </ul>
                    </li>
                    <li>Maintain at least a <strong>C (2.0) average</strong> in any major or
                        minor.</li>
                    <li>Only <strong>one (1) undergraduate degree</strong> may be earned from
                        Emory.</li>
                </ul>
            </div>
            <div id="alpha">
                <a name="alpha"/>
                <table border="1" id="major_minor" summary="Essential major and minor information.">
                    <tr>
                        <th id="name">Name</th>
                        <th id="ba">BA</th>
                        <th id="bs">BS</th>
                        <th id="hours">Hours</th>
                    </tr>
                    <xsl:for-each select="system-page">
                        <xsl:sort order="ascending" select="display-name"/>
                        <xsl:if test="not(system-page/name='index')">
                            <tr>
                                <td class="name">
                                    <a href="{path}" title="display-name">
                                        <xsl:value-of select="display-name"/>
                                    </a>
                                </td>
                                <td class="ba">
                                    <xsl:if test="dynamic-metadata[name='Degree']/value='BA'"> X
                                    </xsl:if>
                                </td>
                                <td class="bs">
                                    <xsl:if test="dynamic-metadata[name='Degree']/value='BS'"> X
                                    </xsl:if>
                                </td>
                                <td class="hours">
                                    <xsl:if
                                        test="not(dynamic-metadata[name='CompletionHoursMaximumValue']/value='0')">
                                        <xsl:value-of
                                            select="dynamic-metadata[name='CompletionHoursMaximumValue']/value"
                                        />
                                    </xsl:if>
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </div>
            <p/>
        </div>
    </xsl:template>

    <xsl:template match="system-page"/>

</xsl:stylesheet>
