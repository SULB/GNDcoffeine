###
 * @author Robert Kolatzek
 * @version 1.0
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
$=jQuery
gndData = {}
gndXhr = {}
gndXhrType = 'exact'

_SEPARATOR_ = ','

$ ->
  imFeld = $.trim($(swdId).val())
  wortArr = imFeld.split("#{_SEPARATOR_}")
  for i in wortArr
    if $.trim(i) != ""
      str = coffeePrintf([
        schlagwortSpanselected
        {
          schlagwort: $.trim(i.replace("<", "&lt;").replace("\"", "&quote;"))
          'swdWortClass': swdWortClass
        }
      ]...)
      $(swdDivSammlungId).append $(str)
  $(".#{swdWortClass}").unbind 'click'
  $(".#{swdWortClass}").bind 'click', removeGngItem
  $(swdErsatzNachrichtId).empty()
  $(gndFormHtml).insertAfter gndDivInsertAfterId
  $(gndDivInsertAfterId).append $("<input type='text' id='#{swdId.replace('#', '')}' name='#{swdId.replace('#', '')}'/>")
  if exactSearchId.length > 0
    $(exactSearchId).bind 'click',exactSearch
  $("<br/><div id='swd_div_sammlung'>#{schlagwortUebernehmen}</div>").insertAfter insertswdCollectionAfterId
  $(swdId).val appendSwdItem(swdId, '')
  $(xgndSearchFormId).fadeIn('slow')
  $("form#{xgndSearchFormId}").unbind('submit').bind 'submit',exactSearch
  $(partSearchButtonId).unbind('click').bind 'click',searchGND
  if typeof window.onpopstate != "undefined"
    window.onpopstate = (event) ->
      GNDcoffeineState = event.state
      if typeof GNDcoffeineState['swdsuche'] != 'undefined'
        $(suchwortId).val GNDcoffeineState['swdsuche']
        $('html, body').animate {scrollTop: $(xgndSearchFormId).offset().top}, 100
        searchGND()
      true
  true

searchGND =->
  try
    event.preventDefault()
  gndData = {}
  $(gndsDiv).html bitteWarten
  gndXhrType = 'part'
  ajaxGnd "pica.sw", $(suchwortId).val(), "pica.tbs=\"s\"", "listGndTypes", gndTimeoutWarning
  false

listGndTypes = (txt) ->
  # dummy-Aufruf, damit die Daten der Funktion zur Verfügung stehen... 
  #console.log(txt)
  window.clearTimeout window.gndLoadTimeout
  $(gndsDiv).empty()
  if gndXhrType == 'exact'
    $(gndsDiv).html exactSearchResultMsg
  else if gndXhrType == 'part'
    $(gndsDiv).html fuzzySearchResultMsg

  if typeof window.history.pushState != "undefined"
    document.title =  "#{document.title.split('| ' + documentHistoryItem)[0]} | #{documentHistoryItem} #{$(suchwortId).val()}"
    history.pushState {swdsuche: $(suchwortId).val()}, "#{documentHistoryItem} #{$(suchwortId).val()}", "#"+encodeURIComponent($(suchwortId).val())
  $(xgndSearchFormId).css('cursor','default')
  if txt 
    txt.forEach (n) -> 
      typ = n.Typ
      if not gndData[typ]
        gndData[typ] = [n]
      else
        gndData[typ] = gndData[typ].concat n
    for typ, i of gndData
      elems = {}
      for i, elem of gndData[typ]
        elems[elem.Ansetzung] = elem
      gndData[typ] = elems
    for typ, i of gndData
      str = coffeePrintf(
        [
          zeigeListeDerGruppeTyp
          {
            "typ": typ
          }
        ]...
      )
      $(gndsDiv).append $("<fieldset class='gnd_typ' data-typ='#{typ}' id='fieldset_#{typ}'><legend><a href='#' title='#{str}'>#{typ} (#{Object.keys(i).length})</a></legend></fieldset>")
      $('.gnd_typ a').unbind 'click'
      $('.gnd_typ a').bind 'click', openGndType
      if gndXhrType == 'exact'
        $("#fieldset_#{typ} a").click()
  else
    $(gndsDiv).append $(emptyResultWarning)
  false

openGndType =->
  typ = $(this).parent().parent().data 'typ'
  $("#fieldset_#{typ}").css 'cursor','wait'
  if typeof $(this).data('closed') is "undefined" or $(this).data('closed') is true
    $(this).data 'closed', false
    $(this).parent().parent().append $("<ul id='gnd_list_#{typ}' class='gnd_list'></ul>")
    if gndData[typ]
      gndSortedType = (k for k of gndData[typ])
      gndSortedType.sort()
      gndSortedTypeObjects = {}
      for i,obj of gndData[typ]
        gndSortedTypeObjects[obj.Ansetzung] = obj
      for k in gndSortedType
        obj = gndSortedTypeObjects[k]
        $("#gnd_list_#{typ}").append $("<li id='gnd_list_item_#{obj.PPN}' data-gndppn='#{obj.PPN}' data-gndwort='#{obj.Ansetzung}' class='gnd_list_item'><a href='#' class='takeGndItem' title='#{schlagwortInFundListe}'>#{obj.Ansetzung}</a> <a href='#' class='getItemInfo' title='#{detailsHinweis}'>#{Details}</a> </li>")
      $('.gnd_list_item a').unbind 'click'
      $('.gnd_list_item a.takeGndItem').bind 'click', takeGndItem
      $('.gnd_list_item a.getItemInfo').bind 'click', getItemInfo
  else
    $(this).data 'closed', true
    $("#gnd_list_#{typ}").remove()
  $("#fieldset_#{typ}").css 'cursor','default'
  false
  
takeGndItem =->
  wort = $(this).parent().data('gndwort')
  imFeld = $.trim($(swdId).val())
  wortArr = imFeld.split("#{_SEPARATOR_}")
  for i in wortArr
    if $.trim(wort) == $.trim(i)
      return false
  $(swdId).val appendSwdItem(swdId, wort)
  str = coffeePrintf(
    [
      schlagwortSpanselected
      {
        schlagwort: wort.replace('<', '&lt;').replace("\"", "&quote;")
        'swdWortClass': swdWortClass
      }
    ]...
  )
  $(swdDivSammlungId).append $(str)
  $(".#{swdWortClass}").unbind 'click'
  $(".#{swdWortClass}").bind 'click', removeGngItem
  false
  
getItemInfo = (event) ->
  try
    event.preventDefault()
  ppn = $(this).parent().data 'gndppn'
  if typeof $(this).data('closed') is 'undefined' or $(this).data('closed') == 1
    $(this).data 'closed', 0
    ajaxGnd "pica.ppn", ppn, encodeURIComponent('pica.tbs="s" and '), "zeigeRecord", infoGndTimeout
  else
    $(this).data 'closed', 1
    $("#gnd_list_item_info_#{ppn}").remove()
  false
  
removeGngItem =->
  wort = $(this).data 'wort'
  swdArr = $(swdId).val().split " #{_SEPARATOR_} "
  swdNewArr = []
  for w in swdArr
    if w not in swdNewArr and $.trim(w) != $.trim(wort)
      r = new RegExp("$\s*#{_SEPARATOR_}\s*$","g")
      swdNewArr.push $.trim(w).replace(r, '')
  swds = swdNewArr.join(" #{_SEPARATOR_} ")  
  $(swdId).val(swds)
  $(this).remove()
  
emptySwdList =->
  $(swdId).val('')
  $(swdDivSammlungId).empty()
  
zeigeRecord = (txt) ->
  window.clearTimeout window.gndLoadTimeout
  $(xgndSearchFormId).css 'cursor','default'
  $("#gnd_list_item_#{txt[0].PPN}").append $("<div id='gnd_list_item_info_#{txt[0].PPN}' class='gnd_list_item_info'></div>")
  str1 = coffeePrintf(
    [
      detailsFuerSchlagwort
      {
        schlagwort: txt[0].Ansetzung
      }
    ]...
  )
  tabelle = $("<table class='gnd_list_item_info_table'><caption>#{str1}</caption><thead><tr><td>#{Typ}</td><td>#{Inhalt}</td></tr></thead><tbody></tbody></table>")
  $("#gnd_list_item_info_#{txt[0].PPN}").append tabelle
  for n, v of txt[0]
    if n is 'Verweise' and typeof v != 'undefined' and v.length > 0
      verweiseliste = $("<tr></tr>")
      verweiseliste.append "<td>#{n}</td>"
      liste = ''
      for i in v
        if i.feldname != ""
          liste += " <b>#{i.feldname}</b>: "
        if typeof i.ppn != 'undefined'
          liste += "<i><a href='#' class='item_link' data-ppn='#{i.ppn}'>#{i.linkname}</a></i><br>"
        else
          liste += "<i>#{i.linkname}</i><br>"
      verweiseliste.append($("<td>#{liste}</td>"))
      $("#gnd_list_item_info_#{txt[0].PPN} > table > tbody ").append verweiseliste
      $('.item_link').unbind 'click'
      $('.item_link').bind 'click', searchGndItemById
    else if n == 'Synonyme' and v != null and v.length > 0
      $("#gnd_list_item_info_#{txt[0].PPN} > table > tbody ").append $("<tr><td>#{n}</td><td>#{v.join('; ')}</td></tr>")
    else if n != 'Typ' and n != 'Ansetzung' and n != 'PPN' and v != null and v.length > 0
      $("#gnd_list_item_info_#{txt[0].PPN} > table > tbody ").append $("<tr><td>#{n}</td><td>#{v}</td></tr>")
   
  
searchGndItemById =->
  $(suchwortId).val $(this).text()
  $('html, body').animate {scrollTop: $(xgndSearchFormId).offset().top}, 100
  gndData = {}
  ppn = $(this).data 'ppn'
  $(gndsDiv).html bitteWarten
  gndXhrType = 'exact'
  ajaxGnd "pica.ppn", ppn, encodeURIComponent('pica.tbs="s" and '), "listGndTypes", gndTimeoutWarning
  false
  
exactSearch = ->
  try
    event.preventDefault()
  gndData = {}
  $(gndsDiv).html bitteWarten
  gndXhrType = 'exact'
  ajaxGnd "pica.swr", $(suchwortId).val(), 'pica.tbs="s"', "listGndTypes", gndTimeoutWarning
  false
  
searchGndTimeout = ( jqXHR, textStatus, errorThrown )->
  $(gndsDiv).html dataErrorWarning
    
gndTimeoutWarning =->
  $(gndsDiv).html timeoutWarning
  
infoGndTimeout =->
  $(this).append $("#{timeoutWarning}")
  
ajaxGnd = (searchtype, suchwort, suchoptionen, callbackFunction, gndTimeoutWarningFunction)->
  $(xgndSearchFormId).css 'cursor','wait'
  gndXhr = $.ajax({"url": 'https://xgnd.bsz-bw.de/Anfrage',
  "data": {"suchfeld": searchtype, "suchwort": encodeURIComponent(suchwort) ,"suchfilter": "000000", suchoptionen, "jsonpCallback": callbackFunction},
  "dataType": "jsonp",
  "jsonpCallback": callbackFunction,
  "timeout": gndSearchTimeout,
  "error": "searchGndTimeout"
  })
  window.gndLoadTimeout = window.setTimeout gndTimeoutWarningFunction, gndSearchTimeout

coffeePrintf = (string, values) ->
  for r in string.match /#\{([^\}]+)\}/ig
    string = string.replace r, "#{values[r.replace('#{', '').replace('}', '')]}"
  string
  
appendSwdItem = (swdId, item) ->
  swdlist = $.trim $(swdId).val()
  swdArr = swdlist.split(" #{_SEPARATOR_} ")
  swdNewArr = []
  for w in swdArr
    if $.trim(w) not in swdNewArr and $.trim(w) != ''
      swdNewArr.push w
  if $.trim(item) != '' and item not in swdNewArr
    swdNewArr.push item
  swdNewArr.join(" #{_SEPARATOR_} ")