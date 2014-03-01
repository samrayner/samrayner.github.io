class FluidVideos
  constructor: ->
  @init: (container="body", $videos=null) ->
    $videos ||= $("iframe[src*='vimeo.com'], iframe[src*='youtube.com']")

    $videos.each ->
      $(this)
        .data('aspectRatio', this.height/this.width)
        .removeAttr('height')
        .removeAttr('width')

    $(window).resize ->
      newWidth = $(container).width()
      $videos.each ->
        $elm = $(this)
        $elm
          .width(newWidth)
          .height(newWidth * $elm.data('aspectRatio'))

    $(window).resize()

class Viewport
  constructor: ->
  @getWidth: ->
    size = window
            .getComputedStyle(document.body,':after')
            .getPropertyValue('content')
    size.replace(/\"/g, '')

class Chrome
  constructor: (@selector=".chrome") ->

  addToolbar: ($chrome, id, url, permalink, external) ->
    t = '<form class="toolbar" method="get">'+
    '<div class="button-group left">'+
    ' <a class="prev" href="#prev">Previous</a>'+
    ' <a class="next" href="#next">Next</a>'+
    '</div>'+
    '<div class="button-group right">'+
    ' <a data-icon="redirect" class="info" href="'+permalink+'"'

    t += ' target="_blank"' if external

    t += '>More info</a>'+
    '</div>'+
    '<div class="address">'+
    ' <img src="http://'+url+'/favicon.ico" alt="Favicon" width="16" height="16" />'+
    ' <input name="url" value="'+url+'" />'+
    '</div>'+
    '</form>'

    $chrome.prepend(t)

  onSubmit: (e) ->
    e.preventDefault()
    url = $(this).find("input:first").val()
    url = "http://"+url unless url.indexOf("http://") == 0
    window.open(url)

  onHover: (e) =>
    $target = $(e.currentTarget)

    side = if $target.css("left") == "auto" then "right" else "left"
    farEdge = if side == "left" then "right" else "left"
    zIndex = if e.originalEvent.type == "mouseover" then "102" else "1"

    centerWindowEdge = @getSideOffset($(@selector+":last"), side)

    offsetDiff = centerWindowEdge - @getSideOffset($target, farEdge)
    gap = 5

    offsetDiff *= -1 if side == "right"

    $target
      .css("margin-"+side, offsetDiff-gap+"px")
      .on "webkitTransitionEnd oTransitionEnd transitionend", ->
        $(this)
          .css("z-index", zIndex)
          .css("margin-"+side, "0")

  getSideOffset: ($elm, side) ->
    offset = $elm.offset().left
    offset += $elm.outerWidth() if side == "right"
    offset

  init: ->
    $(@selector).each (i, elm) =>
      $elm = $(elm)
      id = $elm.attr("id")
      url = id.replace(/_/g, ".")
      permalink = $elm.data("permalink")
      external = permalink.indexOf(window.location.hostname) == -1

      @addToolbar($elm, id, url, permalink, external)

      $slideshow = $elm.children(".slideshow").first()

      slider = new flux.slider($slideshow, {
        autoplay: false,
        transitions: ["slide"]
      })

      $slideshow.click ->
        if external
          window.open(permalink, id+"_window")
        else
          window.location.href = permalink

      $elm.find(".next").click (e) ->
        e.preventDefault()
        slider.next("slide")

      $elm.find(".prev").click (e) ->
        e.preventDefault()
        slider.prev("slide")

      $elm.children(".toolbar").submit(@onSubmit)

      $elm.removeClass("hidden")

    $(@selector+":first, "+@selector+":nth-of-type(2)").hover(@onHover)

$ ->
  if Viewport.getWidth() == "wide"
    $("body#home #status p:last").append(" Check&nbsp;out some of my recent work below!")
    $(".chrome").addClass("hidden")

    #link images in the same gallery together
    $(".gallery a").each ->
      offset = $(this).parent().offset()
      group = offset.top + offset.left
      $(this).attr("data-fancybox-group", group)

    $("a[data-fancybox-group]").fancybox()

    chrome = new Chrome()
    chrome.init()

  FluidVideos.init(".post")

  $('pre code').each (i, e) ->
    hljs.highlightBlock(e, '  ')
