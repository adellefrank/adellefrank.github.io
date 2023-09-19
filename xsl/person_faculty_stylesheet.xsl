<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="facultyName" select="/system-index-block/calling-page/system-page/title"/>

    <xsl:template match="/system-index-block/calling-page/system-page">
        <xsl:apply-templates select="system-data-structure"/>
    </xsl:template>

    <xsl:template match="system-data-structure[@definition-path='College/person']">
        <div class="faculty">
            <xsl:apply-templates select="EmployeeId"/>
            <xsl:apply-templates select="PositionInfo"/>
            <xsl:apply-templates select="HeadshotFileSmall"/>
            <xsl:apply-templates select="Description"/>
            <xsl:apply-templates select="Resume"/>
            <xsl:apply-templates select="PersonName"/>
            <xsl:apply-templates select="ContactMethod"/>

            <xsl:apply-templates select="HeadshotFileLarge"/>
            <div class="disclaimer">
                <p/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="PersonName"/>

    <xsl:template match="PositionInfo">
        <xsl:choose>
            <xsl:when test="PositionTitle=''"/>
            <xsl:otherwise>
                <div class="position">
                    <strong>
                        <xsl:value-of select="PositionTitle"/>
                    </strong>, <a> <xsl:attribute name="href">
                            <xsl:value-of select="OrganizationalUnitPrimary/path"/>
                        </xsl:attribute>
                        <xsl:value-of select="OrganizationalUnitPrimary/display-name"/>
                    </a>
                </div>
                <xsl:if test="not(OrganizationalUnitsAssociated/AssociatedDepartment/path='/')">
                    <xsl:for-each select="OrganizationalUnitsAssociated/AssociatedDepartment">
                        <div class="position">
                            <strong>Associated Department</strong>: <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="path"/>
                                </xsl:attribute>
                                <xsl:value-of select="display-name"/>
                            </a>
                        </div>
                    </xsl:for-each>

                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ContactMethod"/>

    <xsl:template match="Resume">
        <xsl:if test="not(InternetWebAddress='')">
            <br/>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="InternetWebAddress"/>
                </xsl:attribute>My Website </a>
            <br/>
        </xsl:if>
        <xsl:apply-templates select="ResumeFile"/>
        <xsl:apply-templates select="EducationHistory"/>
        <xsl:apply-templates select="InterestsandSpecialties"/>
        <xsl:apply-templates select="Achievements"/>
        <xsl:apply-templates select="Associations"/>
        <xsl:apply-templates select="PublicationHistory"/>
    </xsl:template>

    <xsl:template match="ResumeFile">
        <xsl:if test="not(path='/')">
            <br/>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="path"/>
                </xsl:attribute>My Curriculum Vitae </a>
            <br/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="EducationHistory">
        <xsl:choose>
            <xsl:when
                test="(SchoolOrInstitution/DegreeDate &lt; 1901) or (SchoolOrInstitution/DegreeDate='') or (SchoolOrInstitution/InstitutionName='') or (SchoolOrInstitution/DegreeName='')"/>
            <xsl:otherwise>
                <h4>Education</h4>
                <ul class="educationHistory">
                    <xsl:for-each select="SchoolOrInstitution">

                        <xsl:choose>
                            <xsl:when test="DegreeDate &lt; 1901"/>
                            <xsl:when test="DegreeDate=''"/>
                            <xsl:when test="InstitutionName=''"/>
                            <xsl:when test="DegreeName=''"/>
                            <xsl:when test="DegreeName='Other'">
                                <li>
                                    <xsl:value-of select="DegreeTextName"/>, <xsl:value-of
                                        select="InstitutionName"/>, <xsl:value-of
                                        select="DegreeDate"/>. </li>

                            </xsl:when>
                            <xsl:otherwise>
                                <li>
                                    <xsl:value-of select="DegreeName"/>, <xsl:value-of
                                        select="InstitutionName"/>, <xsl:value-of
                                        select="DegreeDate"/>. </li>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>

                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InterestsandSpecialties">
        <xsl:choose>
            <xsl:when
                test="(Specialties/SpecialtyFreeText[position()=1]='') and (Interests/InterestFreeText[position()=1]='')"/>
            <xsl:otherwise>
                <h4>Interests</h4>
                <ul>
                    <xsl:for-each
                        select="Interests/InterestFreeText | Specialties/SpecialtyFreeText">
                        <xsl:if test="node()">
                            <li class="interest">
                                <xsl:value-of select="node()"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                </ul>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>

    <xsl:template match="Achievements">
        <xsl:choose>
            <xsl:when test="Achievement/Title=''"/>
            <xsl:otherwise>
                <h4>Achievements</h4>
                <ul class="achievements">
                    <xsl:for-each select="Achievement">
                        <li> (<xsl:value-of select="AchievementDate/Year"/>) <em>
                                <xsl:value-of select="Title"/>
                            </em>
                            <xsl:if test="not(Description='')">: <xsl:value-of
                                    select="Description/node()"/>
                            </xsl:if>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Associations">
        <xsl:choose>
            <xsl:when test="Association/Name=''"/>
            <xsl:otherwise>
                <h4>Associations</h4>
                <ul class="associations">
                    <xsl:for-each select="Association">
                        <xsl:choose>
                            <xsl:when test="not(InternetWebAddress='')">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="InternetWebAddress"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="Name"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="Name"/>
                                    </a>
                                </li>
                            </xsl:when>
                            <xsl:otherwise>
                                <li>
                                    <xsl:value-of select="Name"/>
                                </li>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="PublicationHistory">
        <!-- 
      <xsl:choose>
         <xsl:when
            test="(Article/Title='') and (Book/Title='') and (ConferencePaper/Title='') and (WorkingPaper/Title='') and (Podcast/Label='') and (Video/Label='') and (OtherPublication/Title='')"/>
         <xsl:otherwise>
            <h4>Publications</h4>
            <ul class="publicationHistory">
               <xsl:for-each
                  select="Article | Book | ConferencePaper | WorkingPaper | Podcast | Video | OtherPublication">
                  <xsl:sort select="PublicationDate/Year" order="descending"/>
                  <xsl:choose>
                     <xsl:when test="not(Title='')">
                        <xsl:apply-templates
                           select="Article | Book | ConferencePaper | WorkingPaper | OtherPublication"
                        />
                     </xsl:when>
                     <xsl:when test="not(Label='')">
                        <xsl:apply-templates select="Podcast | Video"/>
                     </xsl:when>
                     <xsl:otherwise/>
                  </xsl:choose>
               </xsl:for-each>
            </ul>
         </xsl:otherwise>
      </xsl:choose>
      -->
    </xsl:template>

    <xsl:template match="Description">
        <div class="description">
            <xsl:copy-of select="node()"/>
        </div>
    </xsl:template>

    <xsl:template match="HeadshotFileSmall">
        <xsl:if test="not(path='/')">
            <img alt="headshot" title="headshot">
                <xsl:attribute name="src">
                    <xsl:value-of select="path"/>
                </xsl:attribute>
                <xsl:attribute name="align">left</xsl:attribute>
                <xsl:attribute name="hspace">15</xsl:attribute>
                <xsl:attribute name="vspace">15</xsl:attribute>
            </img>
        </xsl:if>
    </xsl:template>

    <xsl:template match="EmployeeId">
        <div id="toc"> Please <a><xsl:attribute name="href">
                        http://directory.service.emory.edu/?eodentry=<xsl:value-of select="."/>
                </xsl:attribute>click here for this faculty member's CONTACT INFORMATION</a>,
            including phone number(s), e-mail address, and office locations. <em>(Please note that
                detailed contact information is not available for all faculty members, especially
                when accessed from off-campus locations.)</em>
        </div>
    </xsl:template>

    <xsl:template match="Book"/>

    <xsl:template match="Article | ConferencePaper | WorkingPaper">
        <li>
            <!--choose statement for author fields-->
            <xsl:for-each select="Author">
                <xsl:choose>
                    <xsl:when test="not(FamilyName='') and not(GivenName='')">
                        <span class="authorName">
                            <xsl:value-of select="FamilyName"/>, <xsl:value-of select="GivenName"/>.
                        </span>
                    </xsl:when>
                    <xsl:when test="not(FamilyName='') and (GivenName='')">
                        <span class="authorName">
                            <xsl:value-of select="GivenName"/>. </span>
                    </xsl:when>
                    <xsl:when test="(FamilyName='') and not(GivenName='')">
                        <span class="authorName">
                            <xsl:value-of select="GivenName"/>. </span>
                    </xsl:when>
                    <xsl:when test="(FamilyName='') and (GivenName='')"/>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>

            <!--choose statement for publication date field-->
            <xsl:choose>
                <xsl:when test="PublicationDate/Year=''"/>
                <xsl:when test="PublicationDate/Year &lt; 1901"/>
                <xsl:otherwise>
                    <span class="year">
                        <xsl:value-of select="PublicationDate/Year"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for title field-->
            <xsl:choose>
                <xsl:when test="Title=''"/>
                <xsl:when test="not(Title='') and not(InternetWebAddress='')">
                    <span class="title">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="InternetWebAddress"/>
                            </xsl:attribute>
                            <xsl:attribute name="title">
                                <xsl:value-of select="Title"/>
                            </xsl:attribute>
                            <xsl:value-of select="Title"/>. </a>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="title">
                        <xsl:value-of select="Title"/>. </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for journal title field-->
            <xsl:choose>
                <xsl:when test="JournalOrSerialName=''"/>
                <xsl:otherwise>
                    <span class="journal_title">
                        <em>
                            <xsl:value-of select="JournalOrSerialName"/>
                        </em>. <xsl:if test="not(Volume='') and not(Issue='')"> (<xsl:value-of
                                select="Volume"/>:<xsl:value-of select="Issue"/>) </xsl:if>
                        <xsl:if test="not(PageNumber='')"> , <xsl:value-of select="PageNumber"/>.
                        </xsl:if>
                    </span>
                </xsl:otherwise>
            </xsl:choose>

            <!--choose statement for abstract field-->
            <xsl:choose>
                <xsl:when test="Abstract=''"/>
                <xsl:otherwise>
                    <div class="description">
                        <xsl:copy-of select="Abstract/node()"/>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>

    <xsl:template match="Video"> </xsl:template>

    <xsl:template match="Podcast"/>

    <xsl:template match="OrganizationalUnitPrimary"/>

    <xsl:template match="OrganizationalUnitAssociated"/>

    <xsl:template match="HeadshotFileLarge"/>

    <xsl:template match="system-page/system-data-structure"/>

</xsl:stylesheet>
