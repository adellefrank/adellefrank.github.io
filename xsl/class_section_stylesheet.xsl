<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="system-index-block">
        <div class="course">
            <xsl:apply-templates select="calling-page/system-page"/>
        </div>
    </xsl:template>

    <xsl:template match="calling-page/system-page">

        <xsl:variable name="testing" select="dynamic-metadata[name='topic_display_name']/value"/>
        <xsl:if test="$testing">
            <h2 class="atlas_topic">Topic: <xsl:value-of select="$testing"/>
            </h2>
        </xsl:if>

        <div class="notes">
            <xsl:apply-templates select="system-data-structure/PeopleSoftCodes"/>

            <xsl:for-each select="//dynamic-metadata[name='Status']">
                <xsl:if test="not(value='Yes')">
                    <div class="sectionCancelled">
                        <strong>
                            <font color="red">CANCELLED.</font>
                        </strong>
                    </div>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//dynamic-metadata[name='Session']">
                <xsl:if test="not(value='1')">
                    <div class="session">
                        <strong>Session: </strong>
                        <xsl:value-of select="value"/>
                        <br/>
                        <br/>
                    </div>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="dynamic-metadata[name='FirstYearAudience']">
                <xsl:if test="not(value='No')">
                    <div class="sectionFirstYear"> Appropriate for First Year students. </div>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//dynamic-metadata[name='StudyAbroad']">
                <xsl:if test="not(value='No')">
                    <div class="sectionAbroad"> Study abroad class. </div>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//dynamic-metadata[name='Lab']">
                <xsl:if test="not(value='No')">
                    <div class="sectionLab"> Lab component. </div>
                </xsl:if>
            </xsl:for-each>
            <p/>
        </div>

        <table border="1" cellpadding="5" cellspacing="2" id="class_section"
            summary="Essential class scheduling information.">
            <tr>
                <th id="time" width="20%">Time</th>
                <th id="days">Days</th>
                <th id="locale">Location</th>
                <th id="instructor">Instructor</th>
                <th id="ger" width="5%">GER</th>
                <th id="credit">Credit</th>
                <th id="credit">Enrollment Number</th>
                <th id="syllabus" width="10%">Syllabus (Tentative)</th>
            </tr>
            <tr>
                <td class="time">
                    <xsl:choose>
                        <xsl:when test="dynamic-metadata[name='Weekdays1']/value='None'"/>
                        <xsl:otherwise>
                            <div class="time">
                                <span class="startTime">
                                    <xsl:variable name="hour"
                                        select="dynamic-metadata[name='StartTimeHour1']/value"/>
                                    <xsl:variable name="hour2" select="$hour mod 12"/>
                                    <xsl:for-each select="//dynamic-metadata[name='StartTimeHour1']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='StartTimeMinute1']">
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
                                    <xsl:for-each select="//dynamic-metadata[name='EndTimeHour1']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='EndTimeMinute1']">
                                        <xsl:value-of select="value"/>
                                    </xsl:for-each>
                                    <xsl:choose>
                                        <xsl:when test="$hour > 11">pm</xsl:when>
                                        <xsl:when test="$hour &lt; 12">am</xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose></span>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="dynamic-metadata[name='Weekdays2']/value='None'"/>
                        <xsl:when
                            test="not(dynamic-metadata[name='Weekdays2']/value='None') and (dynamic-metadata[name='Weekdays1']/value='None')">
                            <div class="time">
                                <span class="startTime">
                                    <xsl:variable name="hour"
                                        select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                    <xsl:variable name="hour2" select="$hour mod 12"/>
                                    <xsl:for-each select="//dynamic-metadata[name='StartTimeHour2']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='StartTimeMinute2']">
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
                                    <xsl:for-each select="//dynamic-metadata[name='EndTimeHour2']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='EndTimeMinute2']">
                                        <xsl:value-of select="value"/>
                                    </xsl:for-each>
                                    <xsl:choose>
                                        <xsl:when test="$hour > 11">pm</xsl:when>
                                        <xsl:when test="$hour &lt; 12">am</xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose></span>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div class="time2">
                                <span class="startTime">
                                    <xsl:variable name="hour"
                                        select="dynamic-metadata[name='StartTimeHour2']/value"/>
                                    <xsl:variable name="hour2" select="$hour mod 12"/>
                                    <xsl:for-each select="//dynamic-metadata[name='StartTimeHour2']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='StartTimeMinute2']">
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
                                    <xsl:for-each select="//dynamic-metadata[name='EndTimeHour2']">
                                        <xsl:choose>
                                            <xsl:when test="$hour2 > 0">
                                                <xsl:copy-of select="$hour2"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="$hour"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>:<xsl:for-each
                                        select="//dynamic-metadata[name='EndTimeMinute2']">
                                        <xsl:value-of select="value"/>
                                    </xsl:for-each>
                                    <xsl:choose>
                                        <xsl:when test="$hour > 11">pm</xsl:when>
                                        <xsl:when test="$hour &lt; 12">am</xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose></span>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <td class="days">
                    <xsl:choose>
                        <xsl:when test="dynamic-metadata[name='Weekdays1']/value='None'"/>
                        <xsl:otherwise>
                            <div class="days">
                                <xsl:variable name="days">
                                    <xsl:for-each
                                        select="//dynamic-metadata[name='Weekdays1']/value">
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
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="dynamic-metadata[name='Weekdays2']/value='None'"/>
                        <xsl:when
                            test="not(dynamic-metadata[name='Weekdays2']/value='None') and (dynamic-metadata[name='Weekdays1']/value='None')">
                            <div class="days">
                                <xsl:variable name="days">
                                    <xsl:for-each
                                        select="//dynamic-metadata[name='Weekdays2']/value">
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
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div class="days2">
                                <xsl:variable name="days">
                                    <xsl:for-each
                                        select="//dynamic-metadata[name='Weekdays2']/value">
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
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <td class="locale">
                    <xsl:apply-templates select="system-data-structure/InstructionSite"/>
                </td>
                <td class="instructor">
                    <xsl:apply-templates select="system-data-structure/Instructors"/>
                </td>
                <td class="GER">
                    <xsl:for-each
                        select="dynamic-metadata[name='GER']/value | dynamic-metadata[name='GER_variable']/value">
                        <xsl:choose>
                            <xsl:when test="node()='None'"/>
                            <xsl:otherwise>
                                <span class="GER">
                                    <xsl:value-of select="."/>. </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </td>
                <td align="center" class="credits">
                    <xsl:apply-templates select="system-data-structure/Credits"/>
                </td>
                <td align="center" class="enrollment">
                    <xsl:apply-templates select="system-data-structure/PeopleSoftCodes/ClassID"/>
                </td>
                <td align="center" class="syllabus">
                    <xsl:apply-templates select="system-data-structure/InstructorNotes/SyllabusFile"
                    />
                </td>
            </tr>
        </table>
        <p/>
        <div class="dates">
            <em>
                <span class="startDate">
                    <xsl:for-each select="//dynamic-metadata[name='StartTimeMonth']">
                        <xsl:if test="value='01'">January </xsl:if>
                        <xsl:if test="value='02'">February </xsl:if>
                        <xsl:if test="value='03'">March </xsl:if>
                        <xsl:if test="value='04'">April </xsl:if>
                        <xsl:if test="value='05'">May </xsl:if>
                        <xsl:if test="value='06'">June </xsl:if>
                        <xsl:if test="value='07'">July </xsl:if>
                        <xsl:if test="value='08'">August </xsl:if>
                        <xsl:if test="value='09'">September </xsl:if>
                        <xsl:if test="value='10'">October </xsl:if>
                        <xsl:if test="value='11'">November </xsl:if>
                        <xsl:if test="value='12'">December </xsl:if>
                        <xsl:if test="value='None'"/>
                    </xsl:for-each>
                    <xsl:for-each select="//dynamic-metadata[name='StartTimeDay']/value">
                        <xsl:choose>
                            <xsl:when test="node()='None'"/>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>, </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:for-each select="//dynamic-metadata[name='StartTimeYear']/value">
                        <xsl:choose>
                            <xsl:when test="node()='None'"/>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>- </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </span>
                <span class="endDate">
                    <xsl:for-each select="//dynamic-metadata[name='EndTimeMonth']">
                        <xsl:if test="value='01'">January </xsl:if>
                        <xsl:if test="value='02'">February </xsl:if>
                        <xsl:if test="value='03'">March </xsl:if>
                        <xsl:if test="value='04'">April </xsl:if>
                        <xsl:if test="value='05'">May </xsl:if>
                        <xsl:if test="value='06'">June </xsl:if>
                        <xsl:if test="value='07'">July </xsl:if>
                        <xsl:if test="value='08'">August </xsl:if>
                        <xsl:if test="value='09'">September </xsl:if>
                        <xsl:if test="value='10'">October </xsl:if>
                        <xsl:if test="value='11'">November </xsl:if>
                        <xsl:if test="value='12'">December </xsl:if>
                        <xsl:if test="value='None'"/>
                    </xsl:for-each>
                    <xsl:for-each select="//dynamic-metadata[name='EndTimeDay']/value">
                        <xsl:choose>
                            <xsl:when test="node()='None'"/>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>, </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:for-each select="//dynamic-metadata[name='EndTimeYear']/value">
                        <xsl:choose>
                            <xsl:when test="node()='None'"/>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </span>
            </em>
        </div>

        <xsl:apply-templates select="system-data-structure/RelatedCourses"/>

        <xsl:apply-templates select="system-data-structure/CatalogInfo"/>

        <div class="extraInfo">
            <xsl:apply-templates select="system-data-structure/InstructorNotes"/>
        </div>

        <div class="disclaimer">
            <p>The schedule of courses on <a href="http://www.opus.emory.edu" target="_blank"
                    title="Class enrollment">O.P.U.S.</a> is the official listing of courses,
                including days and times they meet and the General Education Requirements they
                satisfy. Students should use course descriptions as general guidelines. Course
                requirements, grading details, book lists, and syllabi are subject to change.</p>
        </div>

        <xsl:apply-templates select="system-data-structure/Number"/>
    </xsl:template>

    <xsl:template match="dynamic-metadata"/>

    <xsl:template match="system-data-structure/PeopleSoftCodes/ClassID">
        <xsl:value-of select="node()"/>
    </xsl:template>

    <xsl:template match="system-data-structure/PeopleSoftCodes">
        <xsl:if test="PermissionRequired='Instructor'">
            <p class="permission">Permission required from instructor to enroll in this class.</p>
        </xsl:if>
        <xsl:if test="PermissionRequired='Department'">
            <p class="permission">Permission required from department to enroll in this class.</p>
        </xsl:if>
    </xsl:template>

    <xsl:template match="system-data-structure/Number"/>

    <xsl:template match="system-data-structure/Title"/>

    <xsl:template match="system-data-structure/Credits">
        <xsl:choose>
            <xsl:when test="CreditMinimumValue='0'"/>
            <xsl:when test="CreditMaximumValue='0'"/>
            <xsl:when test="CreditMaximumValue=CreditMinimumValue">
                <span class="courseCredits">
                    <xsl:value-of select="CreditMinimumValue"/>
                </span>
            </xsl:when>

            <xsl:otherwise>
                <span class="courseCredits">Up to <xsl:value-of select="CreditMaximumValue"/>
                    hours.</span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="system-data-structure/InstructionSite">
        <xsl:choose>
            <xsl:when test="not(InstructionSitePeoplesoft1='') and InstructionSitePeoplesoft2=''">
                <div class="instruction_site">
                    <xsl:value-of select="InstructionSitePeoplesoft1"/>
                </div>
            </xsl:when>
            <xsl:when test="not(InstructionSitePeoplesoft2='') and (InstructionSitePeoplesoft1='')">
                <div class="instruction_site">
                    <xsl:value-of select="InstructionSitePeoplesoft2"/>
                </div>
            </xsl:when>
            <xsl:when
                test="not(InstructionSitePeoplesoft2='') and not(InstructionSitePeoplesoft1='')">
                <div class="instruction_site">
                    <xsl:value-of select="InstructionSitePeoplesoft1"/>
                </div>
                <div class="instruction_site2">
                    <xsl:value-of select="InstructionSitePeoplesoft2"/>
                </div>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="system-data-structure/Instructors">
        <xsl:for-each select="Instructor">
            <xsl:choose>
                <xsl:when test="(PersonInstructor/path='/') and not(FormattedName='')">
                    <span>
                        <xsl:value-of select="FormattedName"/>
                    </span>. </xsl:when>
                <xsl:when test="not(PersonInstructor/path='/')">
                    <span>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="PersonInstructor/path"/>
                            </xsl:attribute>
                            <xsl:value-of select="PersonInstructor/display-name"/>
                        </a>
                    </span>. </xsl:when>
                <xsl:when test="(PersonInstructor/path='/') and (FormattedName='')"/>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>

    </xsl:template>

    <xsl:template match="system-data-structure/CatalogInfo">
        <p/>
        <div class="courseDescription">
            <xsl:if test="not(path='/')">
                <xsl:if
                    test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">
                    <strong>Catalog Description: </strong>
                    <xsl:copy-of select="content/system-data-structure/Description/node()"/>
                </xsl:if>
            </xsl:if>
        </div>
        <p/>
    </xsl:template>

    <xsl:template match="system-data-structure/InstructorNotes">
        <xsl:choose>
            <xsl:when test="not(NoteMessageInstructor='')">
                <div class="courseDescription">
                    <strong>Semester Details: </strong>
                    <xsl:copy-of select="NoteMessageInstructor/node()"/>
                </div>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="not(InternetWebAddress='')">
                <xsl:apply-templates select="InternetWebAddress"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:apply-templates select="Resources"/>
        <xsl:apply-templates select="Grading"/>
    </xsl:template>

    <xsl:template match="system-data-structure/RelatedCourses">
        <p/>
        <div class="requisites">
            <xsl:if test="not(Prerequisites/Prerequisite='')">
                <div class="prerequisites">
                    <strong> Prerequisites: </strong>
                    <xsl:value-of select="Prerequisites/Prerequisite/node()"/>
                </div>
            </xsl:if>
            <xsl:if test="not(Corequisites/Corequisite='')">
                <div class="corequisites">
                    <strong> Co-requisites: </strong>
                    <xsl:value-of select="Corequisites/Corequisite/node()"/>
                </div>
            </xsl:if>
            <xsl:if
                test="not(CrossListedCourses/CrossListed='') and not(CrossListedCourses/CrossListed='.')">
                <div class="crosslisted">
                    <strong> Crosslisted: </strong>
                    <xsl:value-of select="CrossListedCourses/CrossListed/node()"/>
                </div>
            </xsl:if>
            <xsl:apply-templates select="CrossListedCourses/CrossListedLink/path"/>
            <xsl:apply-templates select="LabCourses/LabCourseLink/path"/>
        </div>
    </xsl:template>

    <xsl:template match="Resources">
        <xsl:apply-templates select="Required"/>
        <xsl:apply-templates select="Recommended"/>
    </xsl:template>

    <xsl:template match="Required">
        <xsl:choose>
            <xsl:when test="RequiredResource/Title=''"/>
            <xsl:otherwise>
                <h4>Required Textbooks, Articles, and Resources</h4>
                <ol class="resources">
                    <xsl:for-each select="RequiredResource">
                        <xsl:choose>
                            <xsl:when test="Title=''"/>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when
                                        test="(ResourceType='Book') or (ResourceType='') or (ResourceType='Other')">
                                        <xsl:call-template name="resource_book"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Article'">
                                        <xsl:call-template name="resource_article"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Movie'">
                                        <xsl:call-template name="resource_movie"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Music'">
                                        <xsl:call-template name="resource_music"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Website'">
                                        <xsl:call-template name="resource_web"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Course Packet'">
                                        <xsl:call-template name="resource_packet"/>
                                    </xsl:when>
                                    <xsl:otherwise/>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </ol>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Recommended">
        <xsl:choose>
            <xsl:when test="RecommendedResource/Title=''"/>
            <xsl:otherwise>
                <h4>Recommended Textbooks, Articles, and Resources</h4>
                <ol class="resources">
                    <xsl:for-each select="RecommendedResource">
                        <xsl:choose>
                            <xsl:when test="Title=''"/>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when
                                        test="(ResourceType='Book') or (ResourceType='') or (ResourceType='Other')">
                                        <xsl:call-template name="resource_book"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Article'">
                                        <xsl:call-template name="resource_article"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Movie'">
                                        <xsl:call-template name="resource_movie"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Music'">
                                        <xsl:call-template name="resource_music"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Website'">
                                        <xsl:call-template name="resource_web"/>
                                    </xsl:when>
                                    <xsl:when test="ResourceType='Course Packet'">
                                        <xsl:call-template name="resource_packet"/>
                                    </xsl:when>
                                    <xsl:otherwise/>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </ol>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="resource_book">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <em>
                            <xsl:value-of select="Title"/>
                        </em>. </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">
                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>
                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template name="resource_article">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <xsl:value-of select="Title"/>. (Article). </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for JournalTitle field-->
            <xsl:choose>
                <xsl:when test="JournalTitle=''"/>
                <xsl:when test="not(JournalTitle='')">
                    <span class="journal_title">
                        <em>
                            <xsl:value-of select="JournalTitle"/>
                        </em>. </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">
                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>

                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template name="resource_movie">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <em>
                            <xsl:value-of select="Title"/>
                        </em>. (Movie). </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">
                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>

                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template name="resource_music">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <em>
                            <xsl:value-of select="Title"/>
                        </em>. (Music). </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">

                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>

                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template name="resource_web">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <xsl:value-of select="Title"/>. </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for InternetWebAddress field-->
            <xsl:choose>
                <xsl:when test="InternetWebAddress=''"/>
                <xsl:when test="not(InternetWebAddress='')">
                    <span class="webaddress">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="InternetWebAddress"/>
                            </xsl:attribute>
                            <xsl:attribute name="title">
                                <xsl:value-of select="Title"/>
                            </xsl:attribute>
                            <xsl:value-of select="InternetWebAddress"/>
                        </a> . (Internet). </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">

                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>

                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template name="resource_packet">
        <li>
            <!--choose statement for author fields-->
            <xsl:choose>
                <xsl:when test="not(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>, <xsl:value-of
                            select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="not(AuthorFamily='') and (AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorFamily"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and not(AuthorGivenName='')">
                    <span class="authorName">
                        <xsl:value-of select="AuthorGivenName"/>. </span>
                </xsl:when>
                <xsl:when test="(AuthorFamily='') and (AuthorGivenName='')"/>
            </xsl:choose>

            <!--choose statement for publication year field-->
            <xsl:choose>
                <xsl:when test="PublicationYear=''"/>
                <xsl:when test="PublicationYear &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationYear"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='')">
                    <span class="title">
                        <em>
                            <xsl:value-of select="Title"/>
                        </em>. (Course Packet). </span>
                </xsl:when>
            </xsl:choose>

            <!--choose statement for standard number fields-->
            <xsl:if test="not(StandardNumber='')">
                <div class="standardNumber">
                    <strong><xsl:value-of select="StandardNumberType"/>: </strong><xsl:value-of
                        select="StandardNumber"/>. </div>
            </xsl:if>

            <!--choose statement for description field-->
            <xsl:choose>
                <xsl:when test="Description=''"/>
                <xsl:when test="not(Description='')">

                    <div class="description">
                        <xsl:copy-of select="Description/node()"/>
                    </div>

                </xsl:when>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template match="SyllabusFile">
        <xsl:choose>
            <xsl:when test="not(path='/')">
                <xsl:if
                    test="(contains(path,'.pdf')) and not(contains(path,'example_syllabus.pdf'))">
                    <a href="{path}">
                        <img alt="PDF document" src="/home/assets/images/pdf_icon_small.gif"/>
                    </a>
                </xsl:if>
                <xsl:if test="contains(path,'.doc')">
                    <a href="{path}">
                        <img alt="Word Document" src="/home/assets/images/word.jpg"/>
                    </a>
                </xsl:if>
                <xsl:if test="contains(path,'example_syllabus.pdf')"> TBA. </xsl:if>
            </xsl:when>
            <xsl:otherwise> TBA. </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InternetWebAddress">
        <br/>
        <div class="sectionHomepage"> Class Section Homepage: <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="node()"/>
                </xsl:attribute>
                <xsl:attribute name="title">Class Section Homepage</xsl:attribute>
                <xsl:value-of select="node()"/>
            </a>
        </div>
    </xsl:template>

    <xsl:template match="Grading">
        <xsl:choose>
            <xsl:when
                test="(Assignments/AssessmentAssignment/Name='') and             (Exams/AssessmentExam/Name='')"/>
            <xsl:otherwise>
                <div class="grading">
                    <h4>Grading</h4>
                    <table border="1" cellpadding="5" cellspacing="2" id="class_section"
                        summary="Major assignments.">
                        <tr>
                            <th id="name">Assignment/Exam</th>
                            <th id="description">Details</th>
                            <th id="percent">% of Total Grade</th>
                        </tr>
                        <xsl:apply-templates select="Assignments"/>
                        <xsl:apply-templates select="Exams"/>
                    </table>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Assignments">
        <xsl:choose>
            <xsl:when test="AssessmentAssignment/Name=''"/>
            <xsl:otherwise>
                <xsl:for-each select="AssessmentAssignment">
                    <xsl:sort order="descending" select="PercentageOfTotalGrade"/>
                    <tr>
                        <td class="name">
                            <xsl:value-of select="Name"/>
                        </td>
                        <td class="description">
                            <xsl:value-of select="Description"/>
                        </td>
                        <td align="center" class="percent">
                            <xsl:if test="not(PercentageOfTotalGrade='')">
                                <xsl:value-of select="PercentageOfTotalGrade"/>% </xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Exams">
        <xsl:choose>
            <xsl:when test="AssessmentExam/Name=''"/>
            <xsl:otherwise>
                <xsl:for-each select="AssessmentExam">
                    <xsl:sort order="descending" select="PercentageOfTotalGrade"/>
                    <tr>
                        <td class="name">
                            <xsl:value-of select="Name"/>
                        </td>
                        <td class="description">
                            <xsl:value-of select="Description"/>
                        </td>
                        <td align="center" class="percent">
                            <xsl:if test="not(PercentageOfTotalGrade='')">
                                <xsl:value-of select="PercentageOfTotalGrade"/>% </xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="LabCourses/LabCourseLink/path"/>

    <xsl:template match="CrossListedCourses/CrossListedLink/path"/>

</xsl:stylesheet>
