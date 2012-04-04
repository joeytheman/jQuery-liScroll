###
  Updated 4-3-2012
  Removed each loop to stop browser cpu spiking in chrome
  
  liScroll 1.0
  Examples and documentation at: 
  http://www.gcmingati.net/wordpress/wp-content/lab/jquery/newsticker/jq-liscroll/scrollanimate.html
  2007-2010 Gian Carlo Mingati
  Version: 1.0.2.1 (22-APRIL-2011)
  Dual licensed under the MIT and GPL licenses:
  http://www.opensource.org/licenses/mit-license.php
  http://www.gnu.org/licenses/gpl.html
  Requires:
  jQuery v1.2.x or later
 ### 
 
jQuery.fn.liScroll = (settings) ->
  settings = jQuery.extend(
    travelocity: 0.07
    , settings)
  for list_item in @
    scrollnews = (spazio, tempo) ->
      strip.animate
        left: "-=" + spazio
        , tempo, "linear", ->
          strip.css "left", containerWidth
          scrollnews totalTravel, defTiming
    strip = jQuery(list_item)
    strip.addClass "newsticker"
    stripWidth = 1
    for strip_li in strip.find("li")
      stripWidth += jQuery(list_item, strip_li).outerWidth(true)
    mask = strip.wrap('<div class="mask"></div>')
    tickercontainer = strip.parent().wrap("<div class='tickercontainer'></div>")
    containerWidth = strip.parent().parent().width()
    strip.width stripWidth
    totalTravel = stripWidth + containerWidth
    defTiming = totalTravel / settings.travelocity
    scrollnews totalTravel, defTiming
    strip.hover (->
      jQuery(list_item).stop()
    ), ->
      offset = jQuery(list_item).offset()
      residualSpace = offset.left + stripWidth
      residualTime = residualSpace / settings.travelocity
      scrollnews residualSpace, residualTime