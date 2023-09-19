<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="xml" omit-xml-declaration="yes"/>

   <!--Define variables to use in string manipulation-->
   <xsl:variable name="department"
      select="system-index-block/calling-page/system-page/system-data-structure/page-content/name"/>

   <xsl:variable name="term">
      <xsl:if test="contains(system-index-block/calling-page/system-page/link,'summer')"
         >summer</xsl:if>
   </xsl:variable>

   <xsl:variable name="subject_length"/>

   <xsl:variable name="subject_length_folder"/>

   <xsl:variable name="folder_name"/>

   <xsl:variable name="folder_name_full"/>

   <xsl:variable name="catalog_number_title"/>

   <xsl:variable name="catalog_title"/>

   <xsl:variable name="section_number"/>

   <!--Define key for Meunchian grouping of summer class_sections by catalog_display_name and section number -->
   <xsl:key name="summer_course_exists" match="system-page"
      use="concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value)"/>

   <!--Define key for Meunchian grouping of class_sections by catalog_display_name -->
   <xsl:key name="course_number_exists" match="system-page"
      use="dynamic-metadata[name = 'catalog_display_name']/value"/>

   <!--Root template for self-referencing Atlas_Department page-->
   <xsl:template match="system-index-block">
      <xsl:apply-templates select="calling-page/system-page/content"/>
      <div class="atlas_department">
         <xsl:apply-templates select="page-content"/>
         <xsl:apply-templates select="file-content"/>
         <xsl:apply-templates select="link-content"/>
      </div>
   </xsl:template>

   <xsl:template match="calling-page/system-page/content">
      <xsl:if test="not(node())">
         <xsl:copy-of select="node()"/>
      </xsl:if>
   </xsl:template>

   <xsl:template match="page-content">
      <div id="toc">
         <h4>On this page</h4>
         <ul>
            <xsl:for-each select="content/system-data-structure/Courses/block-content">
               <li>
                  <a>
                     <xsl:attribute name="href">#<xsl:value-of select="title"/>
                     </xsl:attribute>
                     <xsl:attribute name="title">
                        <xsl:value-of select="display-name"/>
                     </xsl:attribute>
                     <xsl:value-of select="display-name"/>
                  </a>
               </li>
            </xsl:for-each>
            <xsl:for-each select="content/system-data-structure/Courses/Area">
               <xsl:if test="not(Label = '')">
                  <li>
                     <a>
                        <xsl:attribute name="href">#<xsl:value-of select="Label"/></xsl:attribute>
                        <xsl:value-of select="Label"/>
                     </a>
                  </li>
               </xsl:if>
            </xsl:for-each>
         </ul>
         <xsl:apply-templates select="Departments"/>
      </div>
      <xsl:apply-templates select="content/system-data-structure/Courses"/>
   </xsl:template>

   <xsl:template match="content/system-data-structure/Courses">
      <div id="atlas_department_courses">
         <xsl:for-each select="block-content">
            <!-- Anchor tag and heading for this folder (referred to in table of contents "toc") -->
            <a>
               <xsl:attribute name="name">
                  <xsl:value-of select="title"/>
               </xsl:attribute>
            </a>
            <h3>
               <xsl:value-of select="display-name"/>
            </h3>
            <xsl:apply-templates select="content/system-index-block"/>
         </xsl:for-each>

         <xsl:for-each select="Area">

            <xsl:if test="not(Label = '')">
               <div class="courses_area">
                  <a>
                     <xsl:attribute name="name">
                        <xsl:value-of select="Label"/>
                     </xsl:attribute>
                  </a>
                  <h3>
                     <xsl:value-of select="Label"/>
                  </h3>
                  <ul class="course_list">
                     <xsl:for-each select="CatalogCourse">
                        <xsl:sort order="ascending" select="name"/>
                        <xsl:if test="not(link = '/')">
                           <li class="course">
                              <a>
                                 <xsl:attribute name="href">
                                    <xsl:value-of select="link"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="name">
                                    <xsl:value-of select="name"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="target">_blank</xsl:attribute>
                                 <xsl:attribute name="title">
                                    <xsl:value-of select="content/system-data-structure/Description"
                                    />
                                 </xsl:attribute>
                                 <xsl:value-of select="display-name"/>
                              </a>
                           </li>
                        </xsl:if>
                     </xsl:for-each>
                  </ul>
               </div>
            </xsl:if>

         </xsl:for-each>
      </div>
   </xsl:template>

   <xsl:template match="content/system-index-block">
      <xsl:choose>
         <xsl:when test="$term='summer'">
            <xsl:for-each
               select=".//system-page[generate-id() = generate-id(key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))[1])]">
               <xsl:sort select="dynamic-metadata[name = 'catalog_display_name']/value"/>
               <xsl:choose>
                  <xsl:when test="$department='creative_writing'">
                     <xsl:if
                        test="(starts-with(name,'ENGCW')) or (starts-with(name,'ENG191')) or (starts-with(name,'ENG270')) or (starts-with(name,'ENG271'))  or (starts-with(name,'ENG272')) or (starts-with(name,'ENG370R'))  or (starts-with(name,'ENG371R')) or (starts-with(name,'ENG372R')) or (starts-with(name,'ENG373R')) or (starts-with(name,'ENG374R')) or (starts-with(name,'ENG375R')) or (starts-with(name,'ENG376R')) or (starts-with(name,'ENG377R')) or (starts-with(name,'ENG378R')) or (starts-with(name,'ENG379')) or (starts-with(name,'ENG397R')) or (starts-with(name,'ENG491R'))">
                        <div class="sections_group">
                           <h5>
                              <xsl:value-of
                                 select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                           </h5>
                           <xsl:for-each
                              select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                              <xsl:sort select="display-name"/>
                              <xsl:apply-templates select="."/>
                           </xsl:for-each>
                        </div>
                     </xsl:if>
                  </xsl:when>
                  <xsl:when test="$department='irish'">
                     <xsl:if
                        test="((starts-with(name,'ENG205')) or (starts-with(name,'ENG258')) or (starts-with(name,'ENG342'))  or (starts-with(name,'ENG348')) or (starts-with(name,'MUS270')))">
                        <div class="sections_group">
                           <h5>
                              <xsl:value-of
                                 select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                           </h5>
                           <xsl:for-each
                              select="key('summer_course_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                              <xsl:sort select="display-name"/>
                              <xsl:apply-templates select="."/>
                           </xsl:for-each>
                        </div>
                     </xsl:if>
                  </xsl:when>
                  <!--
                     <xsl:when test="$department='neuroscience_behavioral_biology'">
                     <xsl:if
                     test="(starts-with(name,'NBB')) or (starts-with(name,'ANT302')) or (starts-with(name,'ANT305')) or (starts-with(name,'ANT306')) or (starts-with(name,'ANT307')) or (starts-with(name,'ANT313')) or (starts-with(name,'ANT323')) or (starts-with(name,'BIOL241')) or (starts-with(name,'BIOL301')) or (starts-with(name,'BIOL302')) or (starts-with(name,'BIOL320')) or (starts-with(name,'BIOL323')) or (starts-with(name,'BIOL325')) or (starts-with(name,'BIOL336')) or (starts-with(name,'BIOL348')) or (starts-with(name,'BIOL360')) or (starts-with(name,'BIOL402')) or (starts-with(name,'BIOL440')) or (starts-with(name,'BIOL450')) or (starts-with(name,'BIOL475')) or (starts-with(name,'CHEM301')) or (starts-with(name,'CHEM302')) or (starts-with(name,'ECON481')) or (starts-with(name,'PHIL205')) or (starts-with(name,'PHIL360')) or (starts-with(name,'PSYC209')) or (starts-with(name,'PSYC215')) or (starts-with(name,'PSYC302')) or (starts-with(name,'PSYC309')) or (starts-with(name,'PSYC313')) or (starts-with(name,'PSYC320')) or (starts-with(name,'PSYC321')) or (starts-with(name,'PSYC322')) or (starts-with(name,'PSYC323')) or (starts-with(name,'PSYC325')) or (starts-with(name,'PSYC350')) or (starts-with(name,'PSYC414')) or (starts-with(name,'PSYC420')) or (starts-with(name,'PSYC440')) or (starts-with(name,'PSYC475'))">
                     <div class="sections_group">
                     <h5>
                     <xsl:value-of
                     select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                     </h5>
                     <xsl:for-each
                     select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                     <xsl:sort select="display-name"/>
                     <xsl:apply-templates select="."/>
                     </xsl:for-each>
                     </div>
                     </xsl:if>
                     </xsl:when>
                  -->
                  <xsl:otherwise>
                     <div class="sections_group">
                        <h5>
                           <xsl:value-of
                              select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                        </h5>
                        <xsl:for-each
                           select="key('summer_course_exists', concat(dynamic-metadata[name = 'catalog_display_name']/value,'-',dynamic-metadata[name = 'Session']/value))">
                           <xsl:sort select="display-name"/>
                           <xsl:apply-templates select="."/>
                        </xsl:for-each>
                     </div>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <xsl:for-each
               select=".//system-page[generate-id() = generate-id(key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)[1])]">
               <xsl:sort select="dynamic-metadata[name = 'catalog_display_name']/value"/>
               <xsl:choose>
                  <xsl:when test="$department='creative_writing'">
                     <xsl:if
                        test="(starts-with(name,'ENGCW')) or (starts-with(name,'ENG191')) or (starts-with(name,'ENG270')) or (starts-with(name,'ENG271'))  or (starts-with(name,'ENG272')) or (starts-with(name,'ENG370R'))  or (starts-with(name,'ENG371R')) or (starts-with(name,'ENG372R')) or (starts-with(name,'ENG373R')) or (starts-with(name,'ENG374R')) or (starts-with(name,'ENG375R')) or (starts-with(name,'ENG376R')) or (starts-with(name,'ENG377R')) or (starts-with(name,'ENG378R')) or (starts-with(name,'ENG379')) or (starts-with(name,'ENG397R')) or (starts-with(name,'ENG491R'))">
                        <div class="sections_group">
                           <h5>
                              <xsl:value-of
                                 select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                           </h5>
                           <xsl:for-each
                              select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                              <xsl:sort select="display-name"/>
                              <xsl:apply-templates select="."/>
                           </xsl:for-each>
                        </div>
                     </xsl:if>
                  </xsl:when>
                  <xsl:when test="$department='irish'">
                     <xsl:if
                        test="((starts-with(name,'ENG205')) or (starts-with(name,'ENG258')) or (starts-with(name,'ENG342'))  or (starts-with(name,'ENG348')) or (starts-with(name,'MUS270')))">
                        <div class="sections_group">
                           <h5>
                              <xsl:value-of
                                 select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                           </h5>
                           <xsl:for-each
                              select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                              <xsl:sort select="display-name"/>
                              <xsl:apply-templates select="."/>
                           </xsl:for-each>
                        </div>
                     </xsl:if>
                  </xsl:when>
                  <!--
                     <xsl:when test="$department='neuroscience_behavioral_biology'">
                     <xsl:if
                     test="(starts-with(name,'NBB')) or (starts-with(name,'ANT302')) or (starts-with(name,'ANT305')) or (starts-with(name,'ANT306')) or (starts-with(name,'ANT307')) or (starts-with(name,'ANT313')) or (starts-with(name,'ANT323')) or (starts-with(name,'BIOL241')) or (starts-with(name,'BIOL301')) or (starts-with(name,'BIOL302')) or (starts-with(name,'BIOL320')) or (starts-with(name,'BIOL323')) or (starts-with(name,'BIOL325')) or (starts-with(name,'BIOL336')) or (starts-with(name,'BIOL348')) or (starts-with(name,'BIOL360')) or (starts-with(name,'BIOL402')) or (starts-with(name,'BIOL440')) or (starts-with(name,'BIOL450')) or (starts-with(name,'BIOL475')) or (starts-with(name,'CHEM301')) or (starts-with(name,'CHEM302')) or (starts-with(name,'ECON481')) or (starts-with(name,'PHIL205')) or (starts-with(name,'PHIL360')) or (starts-with(name,'PSYC209')) or (starts-with(name,'PSYC215')) or (starts-with(name,'PSYC302')) or (starts-with(name,'PSYC309')) or (starts-with(name,'PSYC313')) or (starts-with(name,'PSYC320')) or (starts-with(name,'PSYC321')) or (starts-with(name,'PSYC322')) or (starts-with(name,'PSYC323')) or (starts-with(name,'PSYC325')) or (starts-with(name,'PSYC350')) or (starts-with(name,'PSYC414')) or (starts-with(name,'PSYC420')) or (starts-with(name,'PSYC440')) or (starts-with(name,'PSYC475'))">
                     <div class="sections_group">
                     <h5>
                     <xsl:value-of
                     select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                     </h5>
                     <xsl:for-each
                     select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                     <xsl:sort select="display-name"/>
                     <xsl:apply-templates select="."/>
                     </xsl:for-each>
                     </div>
                     </xsl:if>
                     </xsl:when>
                  -->
                  <xsl:otherwise>
                     <div class="sections_group">
                        <h5>
                           <xsl:value-of
                              select="dynamic-metadata[name = 'catalog_display_name']/value"/>
                        </h5>
                        <xsl:for-each
                           select="key('course_number_exists', dynamic-metadata[name = 'catalog_display_name']/value)">
                           <xsl:sort select="display-name"/>
                           <xsl:apply-templates select="."/>
                        </xsl:for-each>
                     </div>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template match="system-page">
      <xsl:variable name="catalog_number_title">
         <xsl:value-of select="dynamic-metadata[name='catalog_display_name']/value"/>
      </xsl:variable>
      <xsl:variable name="catalog_title">
         <xsl:value-of
            select="substring-after(dynamic-metadata[name='catalog_display_name']/value, ':')"/>
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
                     <xsl:value-of select="link"/>
                  </xsl:attribute>
                  <xsl:attribute name="target">_blank</xsl:attribute>
                  <xsl:value-of select="$section_number"/>

                  <xsl:choose>
                     <xsl:when
                        test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                           >:<xsl:value-of select="$catalog_title"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="substring-after(display-name,$catalog_title)"/>
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays1']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays2']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays1']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays2']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour2']">
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
               <xsl:if test="not(dynamic-metadata[name='instructors_display_name']/value='')">
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
                     <xsl:value-of select="link"/>
                  </xsl:attribute>
                  <xsl:attribute name="target">_blank</xsl:attribute>
                  <xsl:value-of select="$section_number"/>

                  <xsl:choose>
                     <xsl:when
                        test="(substring-after(display-name,$catalog_title)='') or (substring-after(display-name,$catalog_title)=' ')"
                           >:<xsl:value-of select="$catalog_title"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="substring-after(display-name,$catalog_title)"/>
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays1']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays2']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays1']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour1']">
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
                                 <xsl:for-each select="dynamic-metadata[name='Weekdays2']/value">
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
                                 <xsl:for-each select="dynamic-metadata[name='StartTimeHour2']">
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
                                 <xsl:for-each select="dynamic-metadata[name='EndTimeHour2']">
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
   </xsl:template>

   <xsl:template match="Departments"/>

   <xsl:template match="block-content"/>
   <xsl:template match="file-content"/>
   <xsl:template match="link-content"/>

</xsl:stylesheet>
