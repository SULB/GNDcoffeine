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
documentHistoryItem = 'GND search for '
timeoutWarning = "<span class='gndTimeoutWarning'>Server responds very slowly. Please be patient and use more precise terms next time.</span>"
dataErrorWarning = "<p class='searchGndTimeout'>Server is not responding. Please be patient (up to one minute) and use more precise terms next time.</p>"
emptyResultWarning = "<div class='emptyResult'>No matches found.</div>"
schlagwortSpanselected = '<div class="#{swdWortClass}" title="click to remove \'#{schlagwort}\' from list" data-wort="#{schlagwort}"><span class="wort">#{schlagwort}</span>&nbsp;,&nbsp;</div>'
bitteWarten = '<span class="waitGnd">Please wait, loading…</span>'
zeigeListeDerGruppeTyp = 'Click to show #{typ} keyword group'
schlagwortInFundListe = 'Click to apply'
detailsFuerSchlagwort = '#{schlagwort} Details'
Typ = "Type"
Inhalt = "Content"
Details = "Details"
detailsHinweis = "Click to get additional information about this keyword."
schlagwortUebernehmen = "<i>Keywords to submit to SciDok:</i>&nbsp;"

gndFormHtml = '
<form id="xgndSearchForm" onsubmit="return false;" aria-role="application" aria-labelledby="GNDcoffeineUeberschrift" aria-describedby="GNDcoffeineAnleitung">
  <h1 id="GNDcoffeineUeberschrift">Search for subject headings in GND</h1>
  <p id="GNDcoffeineAnleitung">Start with searching for a term (exact or fuzzy search). Open relevant keyword group like "Person" for people,  "Werk" for books, sculptures, paintings or "Sachschlagwort" for topical subject headings.
    Click on the keyword to apply it. By clicking on "Details" you can get additional information about this keyword (and a list of related keywords).
    You can also remove applied keywords by clicking on it.
  </p>
  <input type="search" placeholder="Term for a keyword" size="40" id="suchwort" />
  <input type="submit" value="exact search" id="exactSearch"/><input type="submit" value="fuzzy search" title="This action can retrive more keywords and it needs more time. Please be patient!" id="partSearchButton" /> 
  <div id="gnds" aria-live="polite" aria-atomic="true" aria-relevant="all"></div>
</form>'

exactSearchResultMsg = "<p>Result of exact search</p>"

fuzzySearchResultMsg = "<p>EResult of fuzzy search:</p>"