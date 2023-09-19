<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&amp;&#160;">]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" omit-xml-declaration="yes"/>

    <!--Define key for Meunchian grouping of summer class_sections by catalog_display_name and section number -->
    <xsl:key name="summer_course_exists" match="system-page"
        use="concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value)"/>

    <!--Define key for Meunchian grouping of class_sections by catalog_display_name -->
    <xsl:key name="course_number_exists" match="system-page"
        use="dynamic-metadata[name = 'catalog_display_name']/value"/>

    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

    <xsl:variable name="term">
        <xsl:if test="contains(system-index-block/calling-page/system-page/path,'summer')"
            >summer</xsl:if>
    </xsl:variable>

    <xsl:variable name="ger_filter_value">
        <xsl:value-of
            select="translate(system-index-block/calling-page/system-page/name,$smallcase,$uppercase)"
        />
    </xsl:variable>

    <!--Root template for self-referencing Atlas_Department page-->
    <xsl:template match="system-index-block/calling-page/system-page">
        <div class="atlas_department">
            <xsl:apply-templates select="system-data-structure"/>
        </div>
    </xsl:template>

    <xsl:template match="system-data-structure">
        <div id="toc">
            <h4>On this page</h4>
            <ul>
                <xsl:choose>
                    <xsl:when test="$term='summer'">
                        <xsl:for-each
                            select="block-content/content/system-index-block/system-folder/system-folder">
                            <xsl:variable name="ger_string">
                                <xsl:for-each
                                    select="system-page/dynamic-metadata[name='GER']/value">
                                    <xsl:value-of select="."/>, </xsl:for-each>
                            </xsl:variable>
                            <xsl:variable name="semester">
                                <xsl:choose>
                                    <xsl:when test="contains(path,'6W1')">6W1</xsl:when>
                                    <xsl:when test="contains(path,'6W2')">6W2</xsl:when>
                                    <xsl:otherwise>Directed &amp; Study Abroad</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:if
                                test="not($ger_filter_value='WRT') and not($ger_filter_value='PED') and contains($ger_string,$ger_filter_value)">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"
                                                />-<xsl:value-of select="$semester"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/> - <xsl:value-of
                                            select="$semester"/>
                                    </a>
                                </li>
                            </xsl:if>
                            <xsl:if
                                test="($ger_filter_value='WRT') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'W,'))">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"
                                                />-<xsl:value-of select="$semester"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/> - <xsl:value-of
                                            select="$semester"/>
                                    </a>
                                </li>
                            </xsl:if>
                            <xsl:if
                                test="($ger_filter_value='PED') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'F,'))">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"
                                                />-<xsl:value-of select="$semester"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/> - <xsl:value-of
                                            select="$semester"/>
                                    </a>
                                </li>
                            </xsl:if>

                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each
                            select="block-content/content/system-index-block/system-folder">
                            <xsl:variable name="ger_string">
                                <xsl:for-each
                                    select="system-page/dynamic-metadata[name='GER']/value">
                                    <xsl:value-of select="."/>, </xsl:for-each>
                            </xsl:variable>
                            <xsl:if
                                test="not($ger_filter_value='WRT') and not($ger_filter_value='PED') and contains($ger_string,$ger_filter_value)">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/>
                                    </a>
                                </li>
                            </xsl:if>
                            <xsl:if
                                test="($ger_filter_value='WRT') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'W,'))">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/>
                                    </a>
                                </li>
                            </xsl:if>
                            <xsl:if
                                test="($ger_filter_value='PED') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'F,'))">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">#<xsl:value-of select="name"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="display-name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="display-name"/>
                                    </a>
                                </li>
                            </xsl:if>

                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </ul>
        </div>
        <xsl:apply-templates select="Departments"/>
        <xsl:apply-templates select="content"/>
        <xsl:apply-templates select="block-content/content/system-index-block"/>
    </xsl:template>

    <xsl:template match="block-content/content/system-index-block">
        <div id="atlas_department_courses">
            <xsl:choose>
                <xsl:when test="$term='summer'">
                    <xsl:for-each select="system-folder/system-folder">
                        <xsl:variable name="ger_string">
                            <xsl:for-each select="system-page/dynamic-metadata[name='GER']/value">
                                <xsl:value-of select="."/>, </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="semester">
                            <xsl:choose>
                                <xsl:when test="contains(path,'6W1')">6W1</xsl:when>
                                <xsl:when test="contains(path,'6W2')">6W2</xsl:when>
                                <xsl:otherwise>Directed &amp; Study Abroad</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:if
                            test="not($ger_filter_value='WRT') and not($ger_filter_value='PED') and contains($ger_string,$ger_filter_value)">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>-<xsl:value-of select="$semester"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/> - <xsl:value-of
                                    select="$semester"/>
                            </h3>

                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if test="contains($ger_string_section,$ger_filter_value)">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                            <xsl:sort select="display-name"/>
                                            <div class="section_list">
                                                <xsl:apply-templates select="."/>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                            test="($ger_filter_value='WRT') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'W,')) and not(contains($ger_string,'F'))">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>-<xsl:value-of select="$semester"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/> - <xsl:value-of
                                    select="$semester"/>
                            </h3>
                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if
                                    test="(contains($ger_string_section,concat(' ',$ger_filter_value)) or contains($ger_string_section,'W,') or contains($ger_string_section,$ger_filter_value)) and not(contains($ger_string_section,'F'))">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                            <xsl:sort select="display-name"/>
                                            <xsl:apply-templates select="."/>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                            test="($ger_filter_value='PED') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'F,'))">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>-<xsl:value-of select="$semester"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/> - <xsl:value-of
                                    select="$semester"/>
                            </h3>
                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if
                                    test="contains($ger_string_section,$ger_filter_value) or contains($ger_string_section,'F,')">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                                            <xsl:sort select="display-name"/>
                                            <xsl:apply-templates select="."/>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>

                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="system-folder">
                        <xsl:variable name="ger_string">
                            <xsl:for-each select="system-page/dynamic-metadata[name='GER']/value">
                                <xsl:value-of select="."/>, </xsl:for-each>
                        </xsl:variable>
                        <xsl:if
                            test="not($ger_filter_value='WRT') and not($ger_filter_value='PED') and contains($ger_string,$ger_filter_value)">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/>
                            </h3>

                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if test="contains($ger_string_section,$ger_filter_value)">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                            <xsl:sort select="display-name"/>
                                            <div class="section_list">
                                                <xsl:apply-templates select="."/>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                            test="($ger_filter_value='WRT') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'W,'))">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/>
                            </h3>
                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if
                                    test="(contains($ger_string_section,concat(' ',$ger_filter_value)) or contains($ger_string_section,'W,') or contains($ger_string_section,$ger_filter_value)) and not(contains($ger_string_section,'F'))">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                            <xsl:sort select="display-name"/>
                                            <xsl:apply-templates select="."/>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if
                            test="($ger_filter_value='PED') and (contains($ger_string,$ger_filter_value) or contains($ger_string,'F,'))">
                            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>
                                </xsl:attribute>
                            </a>
                            <h3>
                                <xsl:value-of select="display-name"/>
                            </h3>
                            <xsl:for-each
                                select=".//system-page[generate-id() = generate-id(key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)[1])]">
                                <xsl:sort
                                    select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                                <xsl:variable name="ger_string_section">
                                    <xsl:for-each
                                        select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                        <xsl:value-of select="dynamic-metadata[name = 'GER']/value"
                                        />, </xsl:for-each>
                                </xsl:variable>
                                <xsl:if
                                    test="contains($ger_string_section,$ger_filter_value) or contains($ger_string_section,'F,')">
                                    <div class="sections_group">
                                        <h5>
                                            <xsl:value-of
                                                select="dynamic-metadata[name = 'catalog_display_name']/value"
                                            />
                                        </h5>
                                        <xsl:for-each
                                            select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                                            <xsl:sort select="display-name"/>
                                            <xsl:apply-templates select="."/>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>

                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <xsl:template match="content">
        <xsl:if test="not(node()='')">
            <div>
                <xsl:copy-of select="node()"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="system-page">
        <xsl:if
            test="not($ger_filter_value='WRT') and not($ger_filter_value='PED') and starts-with(dynamic-metadata[name='GER']/value,$ger_filter_value)">
            <xsl:variable name="catalog_number_title">
                <xsl:value-of select="dynamic-metadata[name='catalog_display_name']/value"/>
            </xsl:variable>
            <xsl:variable name="catalog_title">
                <xsl:value-of
                    select="substring-after(dynamic-metadata[name='catalog_display_name']/value, ':')"
                />
            </xsl:variable>
            <xsl:variable name="catalog_name_end" select="substring-after(display-name,'-')"/>
            <xsl:variable name="section_number">
                <xsl:value-of select="substring($catalog_name_end,1,3)"/>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="dynamic-metadata[name='Status']/value='No'">
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <span class="cancelled"> CANCELLED.</span>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">

                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>

                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>
                        <xsl:if
                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                            <xsl:variable name="length"
                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                            <span class="instructor">
                                <xsl:value-of
                                    select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                />
                            </span>
                        </xsl:if>
                    </div>

                </xsl:when>
                <xsl:otherwise>
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <xsl:for-each
                            select="dynamic-metadata[name='GER']/value | dynamic-metadata[name='GER_variable']/value">
                            <xsl:choose>
                                <xsl:when test="node()='None'"/>
                                <xsl:otherwise> &#160;<span class="GER">
                                        <xsl:value-of select="."/>.&#160;</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>

                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>

                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>

                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>

                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if
            test="($ger_filter_value='WRT') and (starts-with(dynamic-metadata[name='GER']/value,$ger_filter_value) or (substring(dynamic-metadata[name='GER']/value,4,1)='W'))">
            <xsl:variable name="catalog_number_title">
                <xsl:value-of select="dynamic-metadata[name='catalog_display_name']/value"/>
            </xsl:variable>
            <xsl:variable name="catalog_title">
                <xsl:value-of
                    select="substring-after(dynamic-metadata[name='catalog_display_name']/value, ':')"
                />
            </xsl:variable>
            <xsl:variable name="catalog_name_end" select="substring-after(display-name,'-')"/>
            <xsl:variable name="section_number">
                <xsl:value-of select="substring($catalog_name_end,1,3)"/>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="dynamic-metadata[name='Status']/value='No'">
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <span class="cancelled"> CANCELLED.</span>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">

                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>

                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>
                        <xsl:if
                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                            <xsl:variable name="length"
                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                            <span class="instructor">
                                <xsl:value-of
                                    select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                />
                            </span>
                        </xsl:if>
                    </div>

                </xsl:when>
                <xsl:otherwise>
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <xsl:for-each
                            select="dynamic-metadata[name='GER']/value | dynamic-metadata[name='GER_variable']/value">
                            <xsl:choose>
                                <xsl:when test="node()='None'"/>
                                <xsl:otherwise> &#160;<span class="GER">
                                        <xsl:value-of select="."/>.&#160;</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>

                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>

                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>

                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>

                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if
            test="($ger_filter_value='PED') and (starts-with(dynamic-metadata[name='GER']/value,$ger_filter_value) or (substring(dynamic-metadata[name='GER']/value,3,1)='F'))">
            <xsl:variable name="catalog_number_title">
                <xsl:value-of select="dynamic-metadata[name='catalog_display_name']/value"/>
            </xsl:variable>
            <xsl:variable name="catalog_title">
                <xsl:value-of
                    select="substring-after(dynamic-metadata[name='catalog_display_name']/value, ':')"
                />
            </xsl:variable>
            <xsl:variable name="catalog_name_end" select="substring-after(display-name,'-')"/>
            <xsl:variable name="section_number">
                <xsl:value-of select="substring($catalog_name_end,1,3)"/>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="dynamic-metadata[name='Status']/value='No'">
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <span class="cancelled"> CANCELLED.</span>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">

                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>

                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>
                        <xsl:if
                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                            <xsl:variable name="length"
                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                            <span class="instructor">
                                <xsl:value-of
                                    select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                />
                            </span>
                        </xsl:if>
                    </div>

                </xsl:when>
                <xsl:otherwise>
                    <div class="section_list">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="path"/>
                            </xsl:attribute>
                            <xsl:value-of select="$section_number"/>

                            <xsl:choose>
                                <xsl:when
                                    test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                                        >:<xsl:value-of select="$catalog_title"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="substring-after(display-name,$catalog_title)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>

                        <xsl:for-each
                            select="dynamic-metadata[name='GER']/value | dynamic-metadata[name='GER_variable']/value">
                            <xsl:choose>
                                <xsl:when test="node()='None'"/>
                                <xsl:otherwise> &#160;<span class="GER">
                                        <xsl:value-of select="."/>.&#160;</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>

                        <div class="times">
                            <xsl:choose>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')"/>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and (dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>

                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:when
                                    test="(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <span class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>

                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>

                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>

                                </xsl:when>
                                <xsl:when
                                    test="not(dynamic-metadata[name='Weekdays1']/value='None') and not(dynamic-metadata[name='Weekdays2']/value='None')">
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days1">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays1']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days1='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days1"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour1']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour1']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute1']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                    <div>
                                        <div class="day">
                                            <xsl:variable name="days2">
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='Weekdays2']/value">
                                                  <xsl:sort order="ascending" select="node()"/>
                                                  <xsl:variable name="day" select="."/>
                                                  <xsl:choose>
                                                  <xsl:when test="$day='1'">M</xsl:when>
                                                  <xsl:when test="$day='2'">Tu</xsl:when>
                                                  <xsl:when test="$day='3'">W</xsl:when>
                                                  <xsl:when test="$day='4'">Th</xsl:when>
                                                  <xsl:when test="$day='5'">F</xsl:when>
                                                  <xsl:when test="$day='6'">Sa</xsl:when>
                                                  <xsl:when test="$day='7'">Su</xsl:when>
                                                  <xsl:when test="$day='None'"/>
                                                  <xsl:otherwise/>
                                                  </xsl:choose>
                                                </xsl:for-each>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$days2='MTuWThF'">M-F</xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select="$days2"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                        <span class="time">
                                            <span class="startTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='StartTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose>
                                            </span>-<span class="endTime">
                                                <xsl:variable name="hour"
                                                  select="dynamic-metadata[name='EndTimeHour2']/value"/>
                                                <xsl:variable name="hour2" select="$hour mod 12"/>
                                                <xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeHour2']">
                                                  <xsl:choose>
                                                  <xsl:when test="$hour2 > 0">
                                                  <xsl:copy-of select="$hour2"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:copy-of select="$hour"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>:<xsl:for-each
                                                  select="dynamic-metadata[name='EndTimeMinute2']">
                                                  <xsl:value-of select="value"/>
                                                </xsl:for-each>
                                                <xsl:choose>
                                                  <xsl:when test="$hour > 11">pm</xsl:when>
                                                  <xsl:when test="$hour &lt; 12">am</xsl:when>
                                                  <xsl:otherwise/>
                                                </xsl:choose></span>
                                        </span>
                                        <xsl:if
                                            test="not(dynamic-metadata[name='instructors_display_name']/value='')">
                                            <xsl:variable name="length"
                                                select="string-length(dynamic-metadata[name='instructors_display_name']/value)-2"/>
                                            <span class="instructor">
                                                <xsl:value-of
                                                  select="substring(dynamic-metadata[name='instructors_display_name']/value,1,$length)"
                                                />
                                            </span>
                                        </xsl:if>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </div>

                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Departments"/>

</xsl:stylesheet>
