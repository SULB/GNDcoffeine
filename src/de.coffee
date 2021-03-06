###
* @author Robert Kolatzek
 *     The MIT License (MIT)
 *
 *  Copyright (c) 2015 Dr. Robert Kolatzek
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
###
gndSearchTimeout = 5000
gndDivInsertAfterId = '#swd_div'
insertswdCollectionAfterId = '#partSearchButton'
swdId = '#subject_swd'
swdErsatzNachrichtId = '#swdBereich'
xgndSearchFormId = '#xgndSearchForm'
swdDivSammlungId = '#swd_div_sammlung'
partSearchButtonId = '#partSearchButton'
exactSearchId = '#exactSearch'
swdWortClass = "swd_wort"
gndsDiv = '#gnds'
suchwortId = '#suchwort'
documentHistoryItem = 'GND Suche nach'
timeoutWarning = "<span class='gndTimeoutWarning'>Der Server braucht lange, um eine Antwort zu liefern. Warten Sie bitte die Antwort ab und versuchen Sie mit genaueren Begriffen zu recherchieren.</span>"
dataErrorWarning = "<p class='searchGndTimeout'>Der Server hat keine gültige Antwort ausgeliefert. Warten Sie bitte die Antwort des Servers ab (bis zu einer Minute) und versuchen mit genaueren Begriffen zu recherhieren.</p>"
emptyResultWarning = "<div class='emptyResult'>Die Suche ergab keine Treffer.</div>"
schlagwortSpanselected = '<div class="#{swdWortClass}" title="zum Entfernen von \'#{schlagwort}\' aus der Liste hier klicken" data-wort="#{schlagwort}"><span class="wort">#{schlagwort}</span>&nbsp;,&nbsp;</div>'
bitteWarten = '<span class="waitGnd">bitte warten</span>'
zeigeListeDerGruppeTyp = 'Für eine Liste von Schlagwörtern der Gruppe #{typ}, hier klicken'
schlagwortInFundListe = 'Zum übernehmen hier klicken'
detailsFuerSchlagwort = 'Details für #{schlagwort}'
Typ = "Typ"
Inhalt = "Inhalt"
Details = "Details"
detailsHinweis = "Für weitere Informationen zu diesem Schlagwort bitte hier klicken"
schlagwortUebernehmen = "<i>Schlagwörter, die in SciDok übernommen werden:</i>&nbsp;"

gndFormHtml = '
<form id="xgndSearchForm" onsubmit="return false;" aria-role="application" aria-labelledby="GNDcoffeineUeberschrift" aria-describedby="GNDcoffeineAnleitung">
  <h1 id="GNDcoffeineUeberschrift">Schlagwortsuche in der GND</h1>
  <p id="GNDcoffeineAnleitung">Geben Sie ein (Teil-)Wort ein, starten eine Suchabfrage, klappen die gewünschten Schlagwort-Typen per Klick auf und wählen aus diesen die passenden Schlagwörter aus. 
    Durch die Auswahl werden sie in die Liste oben übernommen. Unter Details finden Sie weitere Angaben zum Schlagwort und verwandte Schlagwörter. Ein Klick auf die 
    gemerkten Schlagwörter entfernt sie wieder aus der Liste.
  </p>
  <input type="search" placeholder="Wort für die Suche in der GND" size="40" id="suchwort" />
  <input type="submit" value="exakte Schlagwortsuche" id="exactSearch"/><input type="submit" value="Teilwortsuche" title="Diese ungenaue Suche kann sehr viele Ergebnisse liefern. Seien Sie daher sehr geduldig!" id="partSearchButton" /> 
  <div id="gnds" aria-live="polite" aria-atomic="true" aria-relevant="all"></div>
</form>'

exactSearchResultMsg = "<p>Ergebnis der exakten Suche:</p>"

fuzzySearchResultMsg = "<p>Ergebnis der Teilwortsuche:</p>"