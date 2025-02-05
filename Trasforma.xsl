<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" encoding="UTF-8" />

    <!-- template radice -->
    <xsl:template match="/">
    <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Progetto di Codifica di Testi</title>
            <link href="https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400..800;1,400..800&amp;display=swap" rel="stylesheet" />


            <link rel="stylesheet" href="stile.css" />
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="scriptino.js"></script>
        </head>
        <body>
        <div class="header">
          <img id="unipi" src="unipi-logo-png-3.png" alt="Università di Pisa"/>

          <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
        </div>

        <h2> Informazioni sui testi e la codifica </h2>
            <div class="teiheader">
            <xsl:apply-templates select="tei:TEI/tei:teiHeader" />
            </div>
            <button id="mostraextra">Mostra Informazioni</button>
                <div class="container">
                 <h2>  Articoli </h2>
                    <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div">
                        <div class="section">
                            <h2>
                                <xsl:value-of select="tei:head" />
                            </h2>
                            <xsl:for-each select="tei:pb">
                                <xsl:variable name="page_id" select="@xml:id" />
                                <div class="page">
                                    <div class="facsimile">
                                        <xsl:apply-templates select="." />
                                    </div>
                                    <table class="columns">
                                        <tbody>
                                            <tr>
                                                <th>Colonna 1</th>
                                                <th>Colonna 2</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="column left">
                                                        <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$page_id) and @n=1]" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="column right">
                                                        <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$page_id) and @n=2]" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                </div>
            
            <div class="glossario">
              <h2>Glossario</h2>

              <h3>Persone</h3>
                <div class="gloss">
                    <xsl:for-each select="//tei:listPerson/tei:person">
                        <div class="item">
                            <strong>
                                <xsl:value-of select="tei:persName/tei:forename" /> 
                              <xsl:text> </xsl:text>
                                <xsl:value-of select="tei:persName/tei:surname" />
                            </strong>
                            (<xsl:value-of select="tei:birth/tei:date/@when" /> – <xsl:value-of select="tei:death/tei:date/@when" />) <br />
                            <em>Occupazione:  </em> <xsl:value-of select="tei:occupation" /> <br />
                            <xsl:if test="tei:persName/tei:ref/@target">
                                <a href="{tei:persName/tei:ref/@target}" target="_blank">Approfondisci</a>
                            </xsl:if>
                        </div>
                    </xsl:for-each>
                </div>

                <h3>Luoghi</h3>
                <div class="gloss">
                    <xsl:for-each select="//tei:listPlace/tei:place">
                        <div class="item">
                            <strong><xsl:value-of select="tei:placeName" /></strong> 
                            (<xsl:value-of select="tei:location/tei:bloc" />) <br />
                            <em>Tipologia:   </em> <xsl:value-of select="@type" />
                        </div>
                    </xsl:for-each>
                </div>

                <h3>Bibliografia</h3>
                <div class="gloss">
                    <xsl:for-each select="//tei:listBibl/tei:bibl">
                        <div class="item">
                            <strong><xsl:value-of select="tei:title" /></strong> <br />
                            <em>Autore:  </em> <xsl:value-of select="tei:author" /> <br />
                            <em>Anno:  </em> <xsl:value-of select="tei:date" /> <br />
                            <em>Editore:  </em> <xsl:value-of select="tei:editor" /> <br />
                            <xsl:if test="tei:ref/@target">
                                <a href="{tei:ref/@target}" target="_blank">Consulta</a>
                            </xsl:if>
                        </div>
                    </xsl:for-each>
                </div>

                <h3>Eventi</h3>
                <div class="gloss">
                    <xsl:for-each select="//tei:listEvent/tei:event">
                        <div class="item">
                            <strong><xsl:value-of select="tei:eventName" /></strong> 
                            (<xsl:value-of select="(@when, @from, @to)[1]" />) 
                            <br />
                            <xsl:if test="tei:ptr/@target">
                                <a href="{tei:ptr/@target}" target="_blank">Approfondisci</a>
                            </xsl:if>
                        </div>
                    </xsl:for-each>
                </div>

                <h3>Organizzazioni</h3>
                <div class="gloss">
                    <xsl:for-each select="//tei:listOrg/tei:org">
                        <div class="item">
                            <strong><xsl:value-of select="tei:orgName/tei:name" /></strong> <br />
                            <em>Periodo:  </em> <xsl:value-of select="tei:state/@from" /> – <xsl:value-of select="tei:state/@to" /> <br />
                            <xsl:if test="tei:orgName/tei:ref/@target">
                                <a href="{tei:orgName/tei:ref/@target}" target="_blank">Approfondisci</a>
                            </xsl:if>
                        </div>
                    </xsl:for-each>
                </div>
          </div>
        </body>
        <footer> 
          <div>
            <p> Il progetto e l'implementazione web sono stati realizzati da Alessandro Esposito per il corso di Codifica di Testi 2023/2024.
            </p>
          </div>
          <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:notesStmt"/>
        </footer>
    </html>
    </xsl:template>


    <!-- teiHeader -->
<xsl:template match="tei:teiHeader">
        <xsl:apply-templates select="tei:fileDesc" />
        <xsl:apply-templates select="tei:encodingDesc" />
</xsl:template>

<!-- fileDesc -->
<xsl:template match="tei:fileDesc">
    <div class="tendina">
        <h2>Descrizione del file</h2>
        <div class="pannello">
        <xsl:apply-templates select="tei:titleStmt" />
        <xsl:apply-templates select="tei:editionStmt" />
        <xsl:apply-templates select="tei:publicationStmt" />
        <xsl:apply-templates select="tei:seriesStmt" />
        <xsl:apply-templates select="tei:sourceDesc" />
        </div>
    </div>
</xsl:template>

<!-- titleStmt -->
<xsl:template match="tei:titleStmt">
        <h3>Titolo e autori</h3>
        <p><strong>Titolo: </strong> <xsl:value-of select="tei:title[@level='m']" /></p>
        <p><strong>Sottotitolo: </strong> <xsl:value-of select="tei:title[@level='s']" /></p>
        <p><strong>Autori: </strong>
            <xsl:for-each select="tei:author">
                <xsl:value-of select="." />
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
        </p>
        <p><strong>Editore: </strong> <xsl:value-of select="tei:editor" /></p>
        <p><strong>Responsibilità: </strong>
            <xsl:value-of select="tei:respStmt/tei:resp" />
            <xsl:value-of select="tei:respStmt/tei:name" />
        </p>
</xsl:template>

<!-- editionStmt -->
<xsl:template match="tei:editionStmt">
        <h3>Edizione</h3>
        <p><strong>Data: </strong> <xsl:value-of select="tei:edition" /></p>
        <p><strong>Coordinazione: </strong>
            <xsl:value-of select="normalize-space(tei:respStmt/tei:name)" />
        </p>
</xsl:template>

<!-- publicationStmt -->
<xsl:template match="tei:publicationStmt">
        <h3>Pubblicazione</h3>
        <p><strong>Pubblicante: </strong> <xsl:value-of select="tei:publisher" /></p>
        <p><strong>Data: </strong> <xsl:value-of select="tei:date" /></p>
        <p><strong>Disponibilità: </strong>
            <xsl:apply-templates select="tei:availability" />
        </p>
</xsl:template>

<!-- availability -->
<xsl:template match="tei:availability">
    <p>
        <xsl:value-of select="tei:p[1]" />
        <xsl:if test="tei:p[2]/tei:ref/@target">
            <a href="{tei:p[2]/tei:ref/@target}"> GitHub</a>
        </xsl:if>
    </p>
</xsl:template>

<!-- seriesStmt -->
<xsl:template match="tei:seriesStmt">
        <h3>Serie</h3>
        <p><strong>Titolo: </strong> <xsl:value-of select="tei:title" /></p>
        <p><strong>Coordinato da: </strong> <xsl:value-of select="tei:respStmt/tei:name" /></p>
</xsl:template>

<!--notesStmt -->
<xsl:template match="tei:notesStmt">
        <h3>Note</h3>
        <p><xsl:value-of select="tei:note" />  <a href="{tei:note/tei:p/tei:ref/@target}" target="_blank">Visita il sito</a></p>
</xsl:template>

<!-- sourceDesc -->
<xsl:template match="tei:sourceDesc">
        <h3>Descrizione della fonte</h3>
        <div>
            <h3>Articoli</h3>
                <xsl:for-each select="tei:biblStruct/tei:analytic">
                    <p>
                        <xsl:value-of select="tei:title" />
                    </p>
                </xsl:for-each>
        </div>

        <div>
            <h3>Monografia</h3>
            <p><strong>Titolo: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:title" /></p>
            <p><strong>Editore: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:editor" /></p>
            <p><strong>Lingua: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:textLang" /></p>

            <p><strong><xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:resp" />:</strong>
                <xsl:for-each select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name">
                    <xsl:value-of select="." />
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </p>

            <p><strong>Luogo di pubblicazione: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:pubPlace" /></p>
            <p><strong>Editore: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:publisher" /></p>
            <p><strong>Anno: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:date" /></p>

            <p><strong>Volume: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='volume']" /></p>
            <p><strong>Numero: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='issue']" /></p>
            <p><strong>Pagine: </strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='page']" /></p>
        </div>
</xsl:template>


<!-- encodingDesc -->
<xsl:template match="tei:encodingDesc">
    <div class="tendina">
        <h2>Descrizione della codifica</h2>
        <div class="pannello">
        <xsl:apply-templates select="tei:projectDesc" />
        <xsl:apply-templates select="tei:samplingDecl" />
        <xsl:apply-templates select="tei:editorialDecl" />
        </div>
    </div>
</xsl:template>

<!-- projectDesc -->
<xsl:template match="tei:projectDesc">
        <h3>Progetto</h3>
        <p> <xsl:value-of select="tei:p" /></p>
</xsl:template>

<!-- samplingDecl -->
<xsl:template match="tei:samplingDecl">
        <h3>Sampling Declaration</h3>
        <p>
            <xsl:value-of select="tei:p" />
        </p>
</xsl:template>

<!-- editorialDecl -->
<xsl:template match="tei:editorialDecl">
        <h3>Dichiarazione editoriale</h3>
        <xsl:apply-templates select="tei:correction" />
        <xsl:apply-templates select="tei:normalization" />
</xsl:template>

<!-- correction -->
<xsl:template match="tei:correction">
        <h3>Correzioni</h3>
        <p>
            <xsl:value-of select="tei:p" />
        </p>
</xsl:template>

<!-- normalization -->
<xsl:template match="tei:normalization">
        <h3>Normalizzazione</h3>
        <p>
            <strong>Fonte: </strong> 
            <a href="{@source}" target="_blank">
            <xsl:value-of select="@source" />
        </a>
        </p>
        <p>
            <xsl:value-of select="tei:p" />
        </p>
</xsl:template>




<xsl:template match="tei:head">
    <div class="blocco" 
         id="{@xml:id}" 
         facs="{@facs}" 
         corresp="{@corresp}">
        <xsl:apply-templates/>
    </div>
</xsl:template>


<xsl:template match="tei:title">
    <xsl:choose>
        <!-- fuori da 'tei:text' con livello 'm' -->
        <xsl:when test="@level='m' and not(ancestor::tei:text)">
            <h1>
                <xsl:value-of select="." />
            </h1>
        </xsl:when>
        <!-- fuori da 'tei:text' con livello 'sub' -->
        <xsl:when test="@level='s' and not(ancestor::tei:text)">
            <h2>
                <xsl:value-of select="." />
            </h2>
        </xsl:when>
        <!-- dentro 'tei:text' con livello 'm' -->
        <xsl:when test="@level='m' and ancestor::tei:text">
            <h2>
                <xsl:apply-templates/>
            </h2>
        </xsl:when>
        <!-- dentro 'tei:text' con livello 'sub' -->
        <xsl:when test="@level='s' and ancestor::tei:text">
            <h3>
                <xsl:apply-templates/>
            </h3>
        </xsl:when>
        <!-- senza attributo 'level', fuori da 'tei:text' -->
        <xsl:when test="not(@level) and not(ancestor::tei:text)">
            <h2 >
                <xsl:value-of select="." />
            </h2>
        </xsl:when>
        <!-- senza attributo 'level', dentro 'tei:text' -->
        <xsl:otherwise>
            <h3>
                <xsl:value-of select="." />
            </h3>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>



  <xsl:template match="tei:text">
    <div class="text">
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <xsl:template match="tei:hi">
    <i><xsl:apply-templates/></i>
  </xsl:template>



  <xsl:template match="tei:div">
    <div class="section">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:surface">
  <div class="surface" id="{@xml:id}">
    <xsl:apply-templates select="tei:graphic"/>
    <xsl:apply-templates select="tei:zone"/>
  </div>
</xsl:template>

<xsl:template match="tei:graphic">
  <img src="{@url}" width="{@width}" height="{@height}" />
</xsl:template>

<xsl:template match="tei:zone">
  <div class="zone" 
       id="{@xml:id}" 
       data-facs="{@start | @corresp}" 
       style="position: absolute; 
              left:{@ulx}px; 
              top:{@uly}px; 
              width:{@lrx - @ulx}px; 
              height:{@lry - @uly}px;">
  </div>
</xsl:template>



 <xsl:template match="tei:ab">
  <div class="blocco" 
       id="{@xml:id}" 
       facs="{@facs}" 
       corresp="{@corresp}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>


 <!-- pb -->
    <xsl:template match="tei:pb">
        <xsl:variable name="pb_id" select="substring-after(@facs, '#')" />
        <xsl:apply-templates select="//tei:facsimile/tei:surface[@xml:id = $pb_id]" />
    </xsl:template>

    <!-- cb -->
    <xsl:template match="tei:cb">
        <xsl:variable name="col_id" select="@xml:id"/>
        <xsl:apply-templates select="following-sibling::tei:ab[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:head[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:closer[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:ab |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:head |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:list" />
    </xsl:template>
    

     <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

  <xsl:template match="tei:date">
    <time id="data" class="extra" title="Data">
      <xsl:value-of select="."/>
    </time>
  </xsl:template>

  <xsl:template match="tei:pc">
    <span class="pc">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>


  <xsl:template match="tei:addName">
    <span id="epithet" class="extra" title="Epiteto">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>


  <xsl:template match="tei:term[@rend='italic']">
    <span id="verbum" class="extra" title="Verbum">
    <i>
      <xsl:apply-templates/>
    </i>
    </span>
  </xsl:template>

  <xsl:template match="tei:choice">
    <span id="choice" class="extra">
        <xsl:choose>
            <!-- sic/corr -->
            <xsl:when test="tei:sic and tei:corr">
                    <xsl:apply-templates select="tei:sic" />
                    <xsl:apply-templates select="tei:corr" />
            </xsl:when>

            <!-- orig/reg -->
            <xsl:when test="tei:orig and tei:reg">
                <span id="orig">
                    <xsl:apply-templates select="tei:orig" />
                </span>
                <span id="reg" title="Regolarizzazione">
                    <xsl:apply-templates select="tei:reg" />
                </span>
            </xsl:when>

            <!-- abbr/expan -->
            <xsl:when test="tei:abbr and tei:expan">
                <span id="abbr">
                    <xsl:apply-templates select="tei:abbr" />
                </span>
                <span class="expan" title="Espansione">
                    <xsl:apply-templates select="tei:expan" />
                </span>
            </xsl:when>

            <!-- default -->
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </span>
</xsl:template>

  <!--sic -->
    <xsl:template match="tei:sic">
        <span id="sic" class="extra" title="Clicca per vedere la correzione">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <!--corr -->
    <xsl:template match="tei:corr">
        <span id="corr" class="extra">
            <xsl:apply-templates />
        </span>
    </xsl:template>

     <!--abbr -->
    <xsl:template match="tei:abbr">
        <span id="abbr" class="extra">
            <xsl:apply-templates />
        </span>
    </xsl:template>

     <!--expan -->
    <xsl:template match="tei:expan">
        <span id="expan" class="extra">
            <xsl:apply-templates />
        </span>
    </xsl:template>




  <xsl:template match="tei:soCalled">
    <span id="citaz" class="extra" title="Citazione">
        <q>
            <xsl:apply-templates />
        </q>
    </span>
</xsl:template>

  <xsl:template match="tei:said">
    <span id="citaz" class="extra" title="Citazione">

            <xsl:apply-templates />
    </span>
</xsl:template>




<xsl:template match="tei:name[@type='person']">
  <xsl:variable name="person_ref" select="substring-after(@ref, '#')" />
  <span id="extraN" class="extra">
    <a class="name" href="{/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:persName/tei:ref/@target}" target="_blank">
      <xsl:apply-templates select="node()"/> 
    </a>
    <span class="info">
      <strong>Nome: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:persName"/><br/>
      <strong>Nascita: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:birth"/><br/>
      <strong>Morte: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:death"/><br/>
      <strong>Professione: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:occupation"/><br/>
    </span>
  </span>
</xsl:template>

<xsl:template match="tei:orgName">
  <xsl:variable name="org_ref" select="substring-after(@ref, '#')" />
  
  <span id="extraO" class="extra">
    <a class="name" href="{/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:orgName/tei:ref/@target}" target="_blank">
      <xsl:apply-templates select="node()"/> 
    </a>
    
    <span class="info">
      <strong>Nome: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:orgName"/> <br/>
      <strong>Tipologia: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:state/@type"/> <br/>
      <strong>Periodo: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:state/@from"/> - <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:state/@to"/><br/>
    </span>
  </span>
</xsl:template>


<xsl:template match="tei:rs">
  <xsl:variable name="rs_ref" select="substring-after(@ref, '#')" />
  
  <span id="extraR" class="extra">
    <a class="name" href="{/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$rs_ref]/tei:orgName/tei:ref/@target}" target="_blank">
      <xsl:apply-templates select="node()"/> 
    </a>
    <span class="info">
      <strong>Nome: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$rs_ref]/tei:orgName"/> <br/>
      <strong>Tipologia: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$rs_ref]/tei:state/@type"/> <br/>
      <strong>Periodo: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$rs_ref]/tei:state/@from"/> - <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$rs_ref]/tei:state/@to"/><br/>
    </span>
  </span>
</xsl:template>


<xsl:template match="tei:name[@type='place']">
  <xsl:variable name="place_ref" select="substring-after(@ref, '#')" />
  <span id="extraL" class="extra">
      <xsl:apply-templates select="node()"/> 
    <span class="info">
      <strong>Nome: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/tei:placeName"/><br/>
      <strong>Tipo: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/@type"/><br/>
      <strong>Località: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/tei:location/tei:bloc"/><br/>
    </span>
  </span>
</xsl:template>

<xsl:template match="tei:country">
  <xsl:variable name="place_ref" select="substring-after(@ref, '#')" />
  <span id="extraL" class="extra">
      <xsl:apply-templates select="node()"/> 
    <span class="info">
      <strong>Nome: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/tei:placeName"/><br/>
      <strong>Tipo: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/@type"/><br/>
      <strong>Località: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place[@xml:id=$place_ref]/tei:location/tei:bloc"/><br/>
    </span>
  </span>
</xsl:template>

<xsl:template match="tei:eventName">
  <xsl:variable name="event_ref" select="substring-after(@ref, '#')" />
  <span id="extraE" class="extra">
  <a class="name" href="{/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:ptr/@target}" target="_blank">
      <xsl:apply-templates select="node()"/> 
    </a>
    <span class="info">
      <strong>Nome: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:eventName"/><br/>
      <strong>Quando: </strong>
<xsl:choose>
  <!-- 'from' e 'to' sono presenti -->
  <xsl:when test="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@from and 
                   /tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@to">
    <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@from"/> - 
    <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@to"/>
  </xsl:when>

  <!-- 'when' è presente -->
  <xsl:when test="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@when">
    <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/tei:date/@when"/>
  </xsl:when>

  <xsl:otherwise>
    <xsl:text>Data non disponibile</xsl:text>
  </xsl:otherwise>
</xsl:choose>
</span>
  </span>
</xsl:template>


<xsl:template match="tei:name[@type='bibl']">
  <xsl:variable name="bibl_ref" select="substring-after(@ref, '#')" />
  
  <span id="extraB" class="extra">
    <a class="name" href="{/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:ref/@target}" target="_blank">
      <xsl:apply-templates select="node()"/>
    </a>
    <span class="info">
      <strong>Titolo: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:title"/> <br/>
      <strong>Autore: </strong> <xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:author"/> <br/>
      <strong>Uscita: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:date"/><br/>
      <strong>Editore: </strong><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:editor"/>
    </span>
  </span>
</xsl:template>
  </xsl:stylesheet>