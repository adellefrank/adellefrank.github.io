<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="deptName">
        <xsl:value-of select="name"/>
    </xsl:variable>

    <xsl:variable name="unitLabel">
        <xsl:if test="/system-page/system-data-structure/UnitType='AcademicDepartment'">Department</xsl:if>
        <xsl:if test="/system-page/system-data-structure/UnitType='AcademicProgram'">Program</xsl:if>
    </xsl:variable>

    <xsl:variable name="leaderLabel" select="/system-page/system-data-structure/LeaderType/node()"/>

    <xsl:template match="/system-page">
        <div role="main">
            <p>Dept Name: <xsl:value-of select="$deptName"/></p>
            <div class="department"> Leader Type: <xsl:value-of select="$leaderLabel"/>
                <xsl:apply-templates select="system-data-structure"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="system-data-structure">
        <div id="toc" role="navigation">

            <ul>
                <li>
                    <a>
                        <xsl:attribute name="href">#majorminor</xsl:attribute>Majors and Minors</a>
                </li>
                <li>
                    <a>
                        <xsl:attribute name="href">#courses</xsl:attribute>Courses </a>

                    <ul>
                        <xsl:for-each select="Courses/Area">
                            <xsl:choose>
                                <xsl:when test="not(courseBlock/path='/')">
                                    <xsl:variable name="subject" select="substring(courseBlock/content/system-index-block/@name,7)"/>
                                    <xsl:variable name="level">
                                        <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                            <xsl:value-of select="substring(substring-after(name,$subject),1,1)"/>, </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:if test="contains($level,'1,')">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">#<xsl:value-of select="courseBlock/display-name"/>100</xsl:attribute>
                                                <xsl:value-of select="courseBlock/display-name"/>
                                                100-Level Courses </a>
                                        </li>
                                    </xsl:if>
                                    <xsl:if test="contains($level,'2,')">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">#<xsl:value-of select="courseBlock/display-name"/>200</xsl:attribute>
                                                <xsl:value-of select="courseBlock/display-name"/>
                                                200-Level Courses </a>
                                        </li>
                                    </xsl:if>
                                    <xsl:if test="contains($level,'3,')">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">#<xsl:value-of select="courseBlock/display-name"/>300</xsl:attribute>
                                                <xsl:value-of select="courseBlock/display-name"/>
                                                300-Level Courses </a>
                                        </li>
                                    </xsl:if>
                                    <xsl:if test="contains($level,'4,')">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">#<xsl:value-of select="courseBlock/display-name"/>400</xsl:attribute>
                                                <xsl:value-of select="courseBlock/display-name"/>
                                                400-Level Courses </a>
                                        </li>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:when test="(courseBlock/path='/') and not(Label = '')">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">#<xsl:value-of select="Label"/></xsl:attribute>
                                            <xsl:value-of select="Label"/>
                                        </a>
                                    </li>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>

                        </xsl:for-each>
                    </ul>
                </li>
                <xsl:if test="not($deptName='language')">
                    <li>
                        <a>
                            <xsl:attribute name="href">#faculty</xsl:attribute>Faculty </a>
                    </li>
                    <li>

                        <a>
                            <xsl:attribute name="href">#otherPrograms</xsl:attribute>Programs </a>
                    </li>
                    <li>
                        <a>
                            <xsl:attribute name="href">#contactInfo</xsl:attribute>Contact
                            information </a>
                    </li>
                </xsl:if>

            </ul>
        </div>
        <xsl:if test="not(ContactInfo/InternetWebAddress/UnderGraduate = '')">
            <div class="url">
                <strong>Department Website</strong>: <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="ContactInfo/InternetWebAddress/UnderGraduate"/>
                    </xsl:attribute>
                    <xsl:value-of select="ContactInfo/InternetWebAddress/UnderGraduate"/>
                </a>
            </div>
        </xsl:if>
        <xsl:apply-templates select="Description"/>
        <a name="majorminor"></a>
        <div id="majorminors">
            <xsl:apply-templates select="Programs/Majors"/>
            <xsl:apply-templates select="Programs/Minors"/>
        </div>
        <xsl:if test="not($deptName='language')">
            <xsl:apply-templates select="People"/>
        </xsl:if>

        <xsl:apply-templates select="Courses"/>

        <xsl:if test="not($deptName='language')">
            <a name="otherPrograms"></a>
            <xsl:apply-templates select="Programs/HonorsProgram"/>
            <xsl:apply-templates select="Programs/StudyAbroad"/>
            <xsl:apply-templates select="Programs/Advising"/>
            <xsl:apply-templates select="Programs/LanguageStudy"/>
            <xsl:apply-templates select="Programs/Internship"/>
            <xsl:apply-templates select="Programs/Award"/>

            <xsl:apply-templates select="Programs/IndependentStudy"/>
            <xsl:apply-templates select="Programs/ProgramSection"/>
            <xsl:apply-templates select="ContactInfo"/>
            <xsl:apply-templates select="UnitType"/>
            <xsl:apply-templates select="LeaderType"/>
            <xsl:apply-templates select="SchoolName"/>
            <xsl:apply-templates select="Calendar"/>
        </xsl:if>
        <div class="disclaimer">
            <p></p>

        </div>
    </xsl:template>

    <xsl:template match="Description">
        <xsl:if test="not(Description = '')">
            <div class="description">
                <p>
                    <xsl:copy-of select="node()"/>
                </p>

            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ContactInfo">
        <xsl:if test="not(InternetEmailAddress/UnderGraduate = '') or not(InternetWebAddress/UnderGraduate = '') or not(Telephone/Extension = '') or not(PostalAddress/AddressLine = '')">
            <div class="contactInfo">
                <a name="contactInfo"></a>
                <h4>Contact Us</h4>
                <div class="campus_mailing_address">
                    <xsl:for-each select="PostalAddress/AddressLine | PostalAddress/BuildingRoom | PostalAddress/Mailstop">
                        <xsl:if test="not(.='')">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:value-of select="PostalAddress/Municipality"/>, <xsl:value-of select="PostalAddress/Region"/><br/>
                    <xsl:value-of select="PostalAddress/PostalCode"/><br/>
                    <br/>
                    <xsl:value-of select="Telephone/AreaCityCode"/>.<xsl:value-of select="Telephone/SubscriberNumber"/>.<xsl:value-of select="Telephone/Extension"/>
                    <br/>
                    <xsl:value-of select="InternetEmailAddress/UnderGraduate"/>
                    <br/>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="InternetWebAddress/UnderGraduate"/>
                        </xsl:attribute>
                        <xsl:value-of select="InternetWebAddress/UnderGraduate"/>
                    </a>
                    <br/>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/Majors">

        <xsl:if test="not(Major/path = '/')">
            <div id="majors">
                <a name="majors"></a>
                <h4>Majors</h4>

                <ul id="majors">
                    <xsl:for-each select="Major">
                        <li class="major">

                            <a>
                                <xsl:attribute name="href">

                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </li>
                    </xsl:for-each>

                </ul>
            </div>
        </xsl:if>

    </xsl:template>

    <xsl:template match="Programs/Minors">
        <xsl:if test="not(Minor/path = '/')">
            <div id="minors">
                <a name="minors"></a>

                <h4>Minors</h4>

                <ul id="minors">
                    <xsl:for-each select="Minor">
                        <li class="minor">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="path"/>

                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/HonorsProgram">
        <xsl:if test="not(Description = '')">
            <h4>Honors Program</h4>
            <xsl:copy-of select="Description/node()"/>
            <br/>
            <a>
                <xsl:attribute name="href">/college/test/academic/policy/honors_program</xsl:attribute>General Honors
                Program information.</a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/StudyAbroad">
        <xsl:if test="not(Description = '')">
            <h4>Study Abroad</h4>
            <xsl:copy-of select="Description/node()"/>
            <br/>
            <a>
                <xsl:attribute name="href">/college/test/academic/center/abroad</xsl:attribute>General Study Abroad
                information.</a>
        </xsl:if>

    </xsl:template>

    <xsl:template match="Programs/Advising">
        <xsl:if test="not(Description = '')">
            <h4>Advising</h4>
            <xsl:copy-of select="Description/node()"/>
            <!-- 
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="Program/path"/>
                </xsl:attribute> General Advising information.</a>
                -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/LanguageStudy">
        <xsl:if test="not(Description = '')">
            <h4>Language Study</h4>
            <xsl:copy-of select="Description/node()"/>
            <!--
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="Program/path"/>
                </xsl:attribute> General Language Study information.</a>
                -->

        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/Internship">
        <xsl:if test="not(Description = '')">
            <h4>Internship</h4>
            <xsl:copy-of select="Description/node()"/>
            <!--
            <a>
                <xsl:attribute name="href">

                    <xsl:value-of select="Program/path"/>
                </xsl:attribute> General Internship information.</a>
                -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/Award">
        <xsl:if test="not(Description = '')">
            <h4>Awards and Honors</h4>

            <xsl:copy-of select="Description/node()"/>
            <!--
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="Program/path"/>
                </xsl:attribute> General Awards information.</a>
                -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/IndependentStudy">
        <xsl:if test="not(Description = '')">
            <h4>Independent Research and Study</h4>
            <xsl:copy-of select="Description/node()"/>
            <!--
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="Program/path"/>
                </xsl:attribute> General Independent Study information.</a>
                -->

        </xsl:if>
    </xsl:template>

    <xsl:template match="Programs/ProgramSection">
        <xsl:if test="not(Label = '')">
            <h4>
                <xsl:value-of select="Program/Title"/>
            </h4>
            <xsl:copy-of select="Program/Description/node()"/>

        </xsl:if>
    </xsl:template>

    <xsl:template match="People">
        <div id="people">
            <xsl:apply-templates select="Faculty"/>
        </div>
    </xsl:template>

    <xsl:template match="Faculty">

        <div id="faculty">
            <a name="faculty"></a>
            <h4>Faculty</h4>

            <xsl:apply-templates select="Leader"/>
            <xsl:apply-templates select="DirectorUndergraduateStudies"/>
            <xsl:for-each select="DirectorGraduateStudies"/>
            <xsl:apply-templates select="CoreFaculty"/>

            <xsl:apply-templates select="AssociatedFaculty"/>
            <xsl:apply-templates select="AdjunctFaculty"/>
            <xsl:apply-templates select="EmeritiFaculty"/>
        </div>
    </xsl:template>

    <xsl:template match="Leader">
        <xsl:if test="not(Leader/path='/')">
            <div>
                <strong> Chair/Director</strong>: <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="path"/>
                    </xsl:attribute>
                    <xsl:value-of select="display-name"/>
                </a>
            </div>

        </xsl:if>
    </xsl:template>

    <xsl:template match="DirectorUndergraduateStudies">
        <xsl:if test="not(DirectorUndergraduateStudies/path='/')">
            <div>
                <strong>Director of Undergraduate Studies</strong>: <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="path"/>
                    </xsl:attribute>
                    <xsl:value-of select="display-name"/>
                </a>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="CoreFaculty">

        <xsl:if test="not(//CoreFacultyMember/path='/')">
            <h5>Core Faculty</h5>
            <ul>
                <xsl:for-each select="CoreFacultyMember">
                    <xsl:if test="not(path='/') and starts-with(path,'/about')">
                        <li class="faculty">
                            <a>
                                <xsl:attribute name="href">

                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </li>
                    </xsl:if>
                </xsl:for-each>
            </ul>
        </xsl:if>

    </xsl:template>

    <xsl:template match="AssociatedFaculty">
        <xsl:if test="not(//AssociatedFacultyMember/path='/')">
            <h5>Associated Faculty</h5>
            <ul>
                <xsl:for-each select="AssociatedFacultyMember">
                    <xsl:if test="not(path='/') and starts-with(path,'/about')">
                        <li class="faculty">

                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </li>
                    </xsl:if>
                </xsl:for-each>

            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="AdjunctFaculty">
        <xsl:if test="not(//AdjunctFacultyMember/path='/')">
            <h5>Adjunct Faculty</h5>
            <ul>
                <xsl:for-each select="AdjunctFacultyMember">

                    <xsl:if test="not(path='/') and starts-with(path,'/about')">
                        <li class="faculty">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </li>

                    </xsl:if>
                </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="EmeritiFaculty">
        <xsl:if test="not(//EmeritiFacultyMember/path='/')">
            <h5>Emeriti Faculty</h5>

            <ul>
                <xsl:for-each select="EmeritiFacultyMember">
                    <xsl:if test="not(path='/') and starts-with(path,'/about')">
                        <li class="faculty">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>

                            </a>
                        </li>
                    </xsl:if>
                </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Staff"/>

    <xsl:template match="Courses">
        <div id="courses">
            <a name="courses"></a>
            <h4>Courses</h4>

            <xsl:if test="not(Description = '')">
                <div class="course_description">
                    <xsl:copy-of select="Description/node()"/>
                </div>
            </xsl:if>

            <xsl:for-each select="Area">
                <xsl:choose>
                    <xsl:when test="not(courseBlock/path='/')">
                        <xsl:variable name="subject" select="substring(courseBlock/content/system-index-block/@name,7)"/>
                        <xsl:variable name="level">
                            <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                <xsl:value-of select="substring(substring-after(name,$subject),1,1)"/>, </xsl:for-each>
                        </xsl:variable>
                        <xsl:if test="contains($level,'1,')">
                            <div class="courses_area">
                                <a>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="courseBlock/display-name"/>100</xsl:attribute>
                                </a>
                                <h5>
                                    <xsl:value-of select="courseBlock/display-name"/> 100-Level
                                    Courses </h5>

                                <ul class="course_list">
                                    <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                        <xsl:sort order="ascending" select="name"/>
                                        <xsl:if test="not(path = '/') and (dynamic-metadata[name='Status']/value='Yes') and starts-with(system-data-structure/Number/CatalogNumber,'1')">
                                            <li class="course">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="concat('/academic/course/',(substring-after((substring-before(path,name)),'/assets/')),'index#',name)"/>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="name">
                                                  <xsl:value-of select="name"/>
                                                  </xsl:attribute>
                                                  <xsl:if test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">

                                                  <xsl:attribute name="title">
                                                  <xsl:value-of select="content/system-data-structure/Description"/>
                                                  </xsl:attribute>
                                                  </xsl:if>
                                                  <xsl:value-of select="display-name"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="contains($level,'2,')">
                            <div class="courses_area">
                                <a>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="courseBlock/display-name"/>200</xsl:attribute>
                                </a>
                                <h5>
                                    <xsl:value-of select="courseBlock/display-name"/> 200-Level
                                    Courses </h5>

                                <ul class="course_list">
                                    <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                        <xsl:sort order="ascending" select="name"/>
                                        <xsl:if test="not(path = '/') and (dynamic-metadata[name='Status']/value='Yes') and starts-with(system-data-structure/Number/CatalogNumber,'2')">
                                            <li class="course">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="concat('/academic/course/',(substring-after((substring-before(path,name)),'/assets/')),'index#',name)"/>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="name">
                                                  <xsl:value-of select="name"/>
                                                  </xsl:attribute>
                                                  <xsl:if test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">

                                                  <xsl:attribute name="title">
                                                  <xsl:value-of select="content/system-data-structure/Description"/>
                                                  </xsl:attribute>
                                                  </xsl:if>
                                                  <xsl:value-of select="display-name"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each>

                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="contains($level,'3,')">
                            <div class="courses_area">
                                <a>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="courseBlock/display-name"/>300</xsl:attribute>
                                </a>
                                <h5>
                                    <xsl:value-of select="courseBlock/display-name"/> 300-Level
                                    Courses </h5>

                                <ul class="course_list">
                                    <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                        <xsl:sort order="ascending" select="name"/>
                                        <xsl:if test="not(path = '/') and (dynamic-metadata[name='Status']/value='Yes') and starts-with(system-data-structure/Number/CatalogNumber,'3')">
                                            <li class="course">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="concat('/academic/course/',(substring-after((substring-before(path,name)),'/assets/')),'index#',name)"/>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="name">
                                                  <xsl:value-of select="name"/>
                                                  </xsl:attribute>
                                                  <xsl:if test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">

                                                  <xsl:attribute name="title">
                                                  <xsl:value-of select="content/system-data-structure/Description"/>
                                                  </xsl:attribute>
                                                  </xsl:if>
                                                  <xsl:value-of select="display-name"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each>

                                </ul>
                            </div>
                        </xsl:if>
                        <xsl:if test="contains($level,'4,')">
                            <div class="courses_area">
                                <a>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="courseBlock/display-name"/>400</xsl:attribute>
                                </a>
                                <h5>
                                    <xsl:value-of select="courseBlock/display-name"/> 400-Level
                                    Courses </h5>

                                <ul class="course_list">
                                    <xsl:for-each select="courseBlock/content/system-index-block/system-page">
                                        <xsl:sort order="ascending" select="name"/>
                                        <xsl:if test="not(path = '/') and (dynamic-metadata[name='Status']/value='Yes') and starts-with(system-data-structure/Number/CatalogNumber,'4')">
                                            <li class="course">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:value-of select="concat('/academic/course/',(substring-after((substring-before(path,name)),'/assets/')),'index#',name)"/>
                                                  </xsl:attribute>
                                                  <xsl:attribute name="name">
                                                  <xsl:value-of select="name"/>
                                                  </xsl:attribute>
                                                  <xsl:if test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">

                                                  <xsl:attribute name="title">
                                                  <xsl:value-of select="content/system-data-structure/Description"/>
                                                  </xsl:attribute>
                                                  </xsl:if>
                                                  <xsl:value-of select="display-name"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each>

                                </ul>
                            </div>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="(courseBlock/path='/') and not(Label = '')">
                        <div class="courses_area">
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="Label"/>

                                </xsl:attribute>
                            </a>
                            <h5>
                                <xsl:value-of select="Label"/>
                            </h5>

                            <ul class="course_list">
                                <xsl:for-each select="CatalogCourse">
                                    <xsl:sort order="ascending" select="name"/>
                                    <xsl:if test="not(path = '/')">

                                        <li class="course">
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:value-of select="concat('/academic/course/',(substring-after((substring-before(path,name)),'/assets/')),'index#',name)"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="name">
                                                  <xsl:value-of select="name"/>
                                                </xsl:attribute>
                                                <xsl:if test="not(content/system-data-structure/Description='') and not(content/system-data-structure/Description='Description')">

                                                  <xsl:attribute name="title">
                                                  <xsl:value-of select="content/system-data-structure/Description"/>
                                                  </xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="display-name"/>
                                            </a>
                                        </li>
                                    </xsl:if>
                                </xsl:for-each>

                            </ul>
                        </div>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>

        </div>
    </xsl:template>

    <xsl:template match="UnitType"/>
    <xsl:template match="LeaderType"/>

    <xsl:template match="SchoolName"/>
    <xsl:template match="Calendar"/>

</xsl:stylesheet>