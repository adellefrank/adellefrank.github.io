<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="system-index-block">
        <xsl:apply-templates select="calling-page/system-page"/>
    </xsl:template>

    <xsl:template match="calling-page/system-page">
        <div class="majorMinor">
            <xsl:choose>
                <xsl:when test="name='engineering'"/>
                <xsl:otherwise>
                    <div id="toc">
                        <xsl:for-each select="dynamic-metadata[name='RegistrarCode']/value">
                            <xsl:if test="not(value = '') and not(value = '0')">
                                <div>
                                    <xsl:value-of
                                        select="//system-data-structure/AcademicConcentration"/>
                                    Code: <strong>
                                        <xsl:value-of
                                            select="//dynamic-metadata[name='RegistrarCode']/value"
                                        />
                                    </strong>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:if test="not(dynamic-metadata[name='Degree']/value='None')">
                            <div>
                                <strong>
                                    <xsl:value-of select="dynamic-metadata[name='Degree']/value"/>
                                </strong> degree awarded </div>
                        </xsl:if>
                        <br/>
                        <xsl:for-each
                            select="dynamic-metadata[name='CompletionHoursMaximumValue']/value">
                            <xsl:choose>
                                <xsl:when test="value = ''"/>
                                <xsl:otherwise>
                                    <div>
                                        <strong><xsl:value-of select="."/> hours</strong> to
                                        complete </div>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <br/>
                        <xsl:for-each select="system-data-structure/Departments">
                            <xsl:if test="not(AssociatedDepartment/path = '/')">
                                <div class="departments"> For the <strong>Declaration of
                                            <xsl:value-of
                                            select="//system-data-structure/AcademicConcentration"/>
                                        Form</strong>, contact the department(s):<ul>
                                        <xsl:for-each select="AssociatedDepartment">
                                            <li class="associated_department">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="path"/>#contactInfo </xsl:attribute>
                                                  <xsl:value-of select="display-name"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="system-data-structure"/>
            <div class="disclaimer">
                <p/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="system-data-structure">
        <xsl:apply-templates select="ContactInfo"/>
        <xsl:apply-templates select="Requirements"/>
        <xsl:apply-templates select="SchoolName"/>
        <xsl:apply-templates select="AcademicConcentration"/>
    </xsl:template>

    <xsl:template match="Requirements">
        <div class="requirements">
            <h3>Requirements</h3>
            <xsl:if test="not(Description = '')">
                <p>
                    <xsl:copy-of select="Description/node()"/>
                </p>
            </xsl:if>

            <xsl:if test="not(Admission = '')">
                <h4>Admissions / Prerequisites</h4>
                <p>
                    <xsl:copy-of select="Admission/node()"/>
                </p>
            </xsl:if>

            <xsl:if test="not(Courses/CourseArea[position()='1']/Label = '')">
                <xsl:apply-templates select="Courses"/>
            </xsl:if>

            <xsl:if test="not(Others/OtherArea/Label = '')">
                <xsl:apply-templates select="Others"/>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="Courses">
        <xsl:for-each select="CourseArea">
            <xsl:if test="not(Label = '')">
                <h4>
                    <xsl:value-of select="Label"/>
                </h4>

                <p>
                    <xsl:copy-of select="Description/node()"/>
                </p>

                <xsl:if test="not(CatalogCourse/path='/')">
                    <ul>
                        <xsl:apply-templates select="CatalogCourse"/>
                    </ul>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="CatalogCourse">
        <xsl:if test="not(path='/')">
            <li class="courseLink">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="path"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of select="display-name"/>
                    </xsl:attribute>
                    <xsl:value-of select="display-name"/>
                </a>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Others">
        <xsl:for-each select="OtherArea">
            <h4>
                <xsl:value-of select="Label"/>
            </h4>
            <p>
                <xsl:copy-of select="Description/node()"/>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="ContactInfo">
        <xsl:if
            test="not((InternetEmailAddress = '') and (InternetWebAddress = '') and (Telephone/Extension = '') and (People/PersonName=''))">
            <h4>Program Contact Information</h4>
            <div class="contactInfo">
                <xsl:if test="not(People/PersonName = '')">
                    <div>
                        <xsl:value-of select="People/PersonName"/>
                    </div>
                </xsl:if>
                <xsl:if test="not(InternetEmailAddress = '')">
                    <div>
                        <xsl:value-of select="InternetEmailAddress"/>
                    </div>
                </xsl:if>
                <xsl:if test="not(InternetWebAddress = '')">
                    <div>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="InternetWebAddress"/>
                            </xsl:attribute>
                            <xsl:value-of select="InternetWebAddress"/>
                        </a>
                    </div>
                </xsl:if>
                <xsl:if test="not(Telephone/Extension = '')">
                    <div>
                        <xsl:value-of select="Telephone/AreaCityCode"/>.<xsl:value-of
                            select="Telephone/SubscriberNumber"/>.<xsl:value-of
                            select="Telephone/Extension"/>
                    </div>
                </xsl:if>
                <xsl:if
                    test="not(PostalAddress/AddressLine = '') or not(PostalAddress/BuildingRoom='')">
                    <div>
                        <div class="address">
                            <xsl:for-each
                                select="PostalAddress/AddressLine|PostalAddress/BuildingRoom">
                                <xsl:if test="not(node()='')">
                                    <xsl:value-of select="."/>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:value-of select="PostalAddress/Municipality"/>, <xsl:value-of
                                select="PostalAddress/Region"/> &#160; <xsl:value-of
                                select="PostalAddress/PostalCode"/><br/>
                        </div>
                        <br/>
                    </div>
                </xsl:if>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="SchoolName"/>
    <xsl:template match="Departments"/>
    <xsl:template match="AcademicConcentration"/>
    <xsl:template match="TotalHours"/>
    <xsl:template match="TotalCourses"/>

</xsl:stylesheet>
