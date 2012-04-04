###
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
  @each ->
    scrollnews = (spazio, tempo) ->
      $strip.animate
        left: "-=" + spazio
      , tempo, "linear", ->
        $strip.css "left", containerWidth
        scrollnews totalTravel, defTiming
    $strip = jQuery(this)
    $strip.addClass "newsticker"
    stripWidth = 1
    $strip.find("li").each (i) ->
      stripWidth += jQuery(this, i).outerWidth(true)

    $mask = $strip.wrap("<div class='mask'></div>")
    $tickercontainer = $strip.parent().wrap("<div class='tickercontainer'></div>")
    containerWidth = $strip.parent().parent().width()
    $strip.width stripWidth
    totalTravel = stripWidth + containerWidth
    defTiming = totalTravel / settings.travelocity
    scrollnews totalTravel, defTiming
    $strip.hover (->
      jQuery(this).stop()
    ), ->
      offset = jQuery(this).offset()
      residualSpace = offset.left + stripWidth
      residualTime = residualSpace / settings.travelocity
      scrollnews residualSpace, residualTime