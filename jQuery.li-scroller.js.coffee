###
 liScroll 1.2 updated by @joeytheman
 liScroll 1.1 updated by @davetayls
 
 Examples and documentation at:
 http://the-taylors.org/blog/2010/03/15/liscroll-jquery-news-ticker-customisation-with-next-previous-play/
 http://www.gcmingati.net/wordpress/wp-content/lab/jquery/newsticker/jq-liscroll/scrollanimate.html
 
 2007-2009 Gian Carlo Mingati
 Dual licensed under the MIT and GPL licenses:
 http://www.opensource.org/licenses/mit-license.php
 http://www.gnu.org/licenses/gpl.html
###

(($) ->
  jQuery.fn.liScroll = (settings) ->
    settings = $.extend(
      travelocity: 0.05
      showControls: false
      , settings)
    for t in @
      scrollnews = (spazio, tempo) ->
        $strip.animate
          left: "-=" + spazio
          , tempo, "linear", ->
            $strip.css "left", containerWidth
            scrollnews totalTravel, defTiming
      strip = t
      $strip = $(strip)
      $strip.addClass "liScroll-ticker"
      $stripItems = $strip.find("li")
      stripWidth = 0
      $mask = $strip.wrap("<div class='liScroll-mask'></div>")
      $tickercontainer = $strip.parent().wrap("<div class='liScroll-container'></div>").parent()
      $strip.before("<div class='liScroll-leftMask'></div>")
      $strip.after("<div class='liScroll-rightMask'></div>")
      paused = false
      containerWidth = $strip.parent().parent().width()

      currentItemIndex = ->
        index = 0
        currentLeft = parseInt($strip.css("left"))
        accumulatedWidth = 0
        if currentLeft > 0
          return 0
        else
          for strip_li in $strip.find("li")
            if currentLeft is (0 - accumulatedWidth)
              index = strip_li
              return false
            accumulatedWidth += $(strip_li).width()
            if currentLeft > (0 - accumulatedWidth)
              index = strip_li
              return false
            true
        index

      next = ->
        pause()
        index = currentItemIndex()
        if index >= $stripItems.length - 1
          $strip.css "left", "0px"
        else
          $itm = $stripItems.eq(index + 1)
          $strip.css "left", (0 - $itm.position().left) + "px"

      pause = ->
        $strip.stop()
        $tickercontainer.removeClass("liScroll-playing").addClass "liScroll-paused"
        paused = true

      previous = ->
        pause()
        index = currentItemIndex()
        $itm = null
        if index is 0
          $itm = $stripItems.eq($stripItems.length - 1)
        else
          $itm = $stripItems.eq(index - 1)
        $strip.css "left", (0 - $itm.position().left) + "px"

      play = ->
        offset = $strip.offset()
        residualSpace = offset.left + stripWidth
        residualTime = residualSpace / settings.travelocity
        scrollnews residualSpace, residualTime
        $tickercontainer.addClass("liScroll-playing").removeClass "liScroll-paused"
        paused = false

      togglePlay = ->
        if paused
          play()
        else
          pause()

      if settings.showControls
        $prev = $("<div class=\"liScroll-prev\">&lt;</div>").appendTo($tickercontainer).click(->
          previous.call strip
        )
        $pause = $("<div class=\"liScroll-play\">Pause</div>").appendTo($tickercontainer).click(->
          togglePlay.call strip
        )
        $next = $("<div class=\"liScroll-next\">&gt;</div>").appendTo($tickercontainer).click(->
          next.call strip
        )
      $strip.width 10000
      $stripItems.each (i) ->
        stripWidth += $(this).outerWidth()

      $strip.width stripWidth
      totalTravel = stripWidth + containerWidth
      defTiming = totalTravel / settings.travelocity
      scrollnews totalTravel, defTiming
      $tickercontainer.addClass "liScroll-playing"
      $strip.hover pause, play
) jQuery