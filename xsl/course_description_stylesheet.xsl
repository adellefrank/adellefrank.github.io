<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="system-page">
        <div class="course">
            <div class="ger">
                <xsl:choose>
                    <xsl:when test="not(//dynamic-metadata[name='GER']/value='None')">
                        <div class="GER"> Primary GER Tag:&#160;&#160;<strong><xsl:value-of
                                    select="dynamic-metadata[name='GER']/value"/></strong>&#160; <xsl:choose>
                                <xsl:when test="dynamic-metadata[name='GER_1_comments']/value"
                                    >&#160;&#160; <em>
                                        <xsl:copy-of
                                            select="dynamic-metadata[name='GER_1_comments']/value"/>
                                    </em>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>&#160;</div>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>

                <xsl:choose>
                    <xsl:when test="not(//dynamic-metadata[name='GER Variable']/value='None')">
                        <br/>
                        <div class="GER">
                            <a>
                                <xsl:attribute name="title">Some--though not many--GER courses carry
                                    variable tags. A course usually will carry the primary GER tag.
                                    A variable GER tag indicates that, depending on the instructor
                                    or other factors, a particular section of a course may carry a
                                    different GER tag than the primary GER tag. Students should
                                    always check OPUS to determine the GER tag that a variably
                                    tagged GER course will carry for a particular semester. All
                                    students enrolled in a single section will receive the same GER
                                    credit--as shown in OPUS--for that course. Students only receive
                                    primary GER tag credit for transfer
                                credits.</xsl:attribute>Variable GER
                                    Tag</a>:&#160;&#160;<strong><xsl:value-of
                                    select="dynamic-metadata[name='GER Variable']/value"
                            /></strong>&#160; <xsl:choose>
                                <xsl:when test="dynamic-metadata[name='GER_2_comments']/value"
                                    >&#160;&#160; <em>
                                        <xsl:copy-of
                                            select="dynamic-metadata[name='GER_2_comments']/value"/>
                                    </em>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose> .&#160;</div>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>

            </div>
            <xsl:apply-templates select="system-data-structure"/>
            <div class="disclaimer">
                <p/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="system-data-structure">
        <xsl:if test="Offering/Status = 'N'">
            <div id="notOffered">
                <strong>This course is not currently offered.</strong>
            </div>
        </xsl:if>
        <xsl:apply-templates select="Credits"/>
        <xsl:apply-templates select="CreditGradingOption"/>
        <xsl:apply-templates select="PermissionRequired"/>
        <br/>
        <xsl:apply-templates select="Description"/>
        <br/>
        <xsl:apply-templates select="RelatedCourses"/>
        <xsl:apply-templates select="Number"/>
        <xsl:apply-templates select="Title"/>
        <xsl:apply-templates select="PeopleSoftIDCodes"/>
        <xsl:apply-templates select="SchoolName"/>
    </xsl:template>

    <xsl:template match="Number"/>

    <xsl:template match="Title"/>

    <xsl:template match="Credits">

        <xsl:choose>
            <xsl:when test="CreditMinimumValue='0'"/>
            <xsl:when test="CreditMaximumValue='0'"/>
            <xsl:when test="CreditMaximumValue=CreditMinimumValue">
                <br/>
                <div class="courseCredits">
                    <xsl:value-of select="CreditMinimumValue"/> Semester Hours</div>
            </xsl:when>
            <xsl:otherwise>
                <br/>
                <div class="courseCredits"> Variable credit, may be repeated for up to <xsl:value-of
                        select="CreditMaximumValue"/> Semester Hours.</div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Description">
        <xsl:if test="node()">
            <xsl:if test="not(node()='Description')">
                <div class="courseDescription">
                    <xsl:value-of select="node()"/>
                </div>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="PeopleSoftIDCodes"/>

    <xsl:template match="RelatedCourses">
        <xsl:choose>
            <xsl:when test="Prerequisites/Prerequisite/path = '/'"/>
            <xsl:otherwise>
                <div class="prerequisiteCourses">
                    <strong>Prerequisites</strong>
                    <xsl:for-each select="Prerequisites/Prerequisite"> :<a href="{path}">
                            <xsl:value-of select="name"/>
                        </a>
                    </xsl:for-each>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="CrossListedCourses/CrossListed/path = '/'"/>
            <xsl:otherwise>
                <div class="crosslistedCourses">
                    <strong>Same as: </strong>
                    <xsl:for-each select="CrossListedCourses/CrossListed"><a href="{path}">
                            <xsl:value-of select="name"/>
                        </a>. </xsl:for-each>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="SchoolName"/>

    <xsl:template match="PermissionRequired">
        <xsl:choose>
            <xsl:when test="node() = 'No Special Consent Required'"/>
            <xsl:when test="node() = 'Other'"/>
            <xsl:otherwise>
                <div class="permission">
                    <em>
                        <xsl:value-of select="."/> to enroll in this course. </em>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="CreditGradingOption">
        <xsl:choose>
            <xsl:when test="node() = 'None' | 'OPT'"/>
            <xsl:when test="node() = 'GRD'">
                <em>This course must be taken for a letter grade.</em>
            </xsl:when>
            <xsl:when test="node() = 'SUS'">
                <em>This course must be taken on a Satisfactory/Unsatisfactory basis.</em>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Offering"/>

</xsl:stylesheet>
