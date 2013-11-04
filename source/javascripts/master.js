var FluidVideos = {
  init: function() {
    var $allVideos = $("iframe[src^='http://player.vimeo.com'], iframe[src^='http://www.youtube.com']");
    var $fluidEl = $(".post");

    $allVideos.each(function() {
      $(this)
        .data('aspectRatio', this.height/this.width)
        .removeAttr('height')
        .removeAttr('width');
    });

    $(window).resize(function() {
      var newWidth = $fluidEl.width();
      $allVideos.each(function() {
        var $el = $(this);
        $el.width(newWidth).height(newWidth * $el.data('aspectRatio'));
      });
    });

    $(window).resize();
  }
};

var Viewport = {
  getWidth: function() {
    var size = window.getComputedStyle(document.body,':after').getPropertyValue('content');
    return size.replace(/\"/g, "");
  }
};

var Chrome = {
  addToolbar: function($chrome, id, url, permalink, external) {
    var t = '<form class="toolbar" method="get">'+
    '<div class="button-group left">'+
    ' <a class="prev" href="#prev">Previous</a>'+
    ' <a class="next" href="#next">Next</a>'+
    '</div>'+
    '<div class="button-group right">'+
    ' <a data-icon="redirect" class="info" href="'+permalink+'"';

    if(external) {
      t += ' target="_blank"';
    }

    t += '>More info</a>'+
    '</div>'+

    '<div class="address">'+
    ' <img src="http://'+url+'/favicon.ico" alt="Favicon" width="16" height="16" />'+
    ' <input name="url" value="'+url+'" />'+
    '</div>'+
    '</form>';

    $chrome.prepend(t);
  },

  onSubmit: function(e) {
    e.preventDefault();

    var url = $(this).find("input:first").val();

    if(url.indexOf("http://") !== 0) {
      url = "http://"+url;
    }

    window.open(url);
  },

  onHover: function(e) {
    var side = $(this).css("left") !== "auto" ? "left" : "right";
    var farEdge = side === "left" ? "right" : "left";
    var zIndex = e.originalEvent.type === "mouseover" ? "102" : "1";

    var centerWindowEdge = Chrome.getSideOffset($(".chrome:last"), side);

    var offsetDiff = centerWindowEdge - Chrome.getSideOffset($(this), farEdge);
    var gap = 5;

    if(side === "right") {
      offsetDiff *= -1;
    }

    $(this)
      .css("margin-"+side, offsetDiff-gap+"px")
      .bind("webkitTransitionEnd oTransitionEnd transitionend", function() {
        $(this)
          .css("z-index", zIndex)
          .css("margin-"+side, "0");
      });
  },

  getSideOffset: function($elm, side) {
    var offset = $elm.offset().left;

    if(side === "right") {
      offset += $elm.outerWidth();
    }

    return offset;
  },

  init: function() {
    $(".chrome").each(function() {
      var id = $(this).attr("id");
      var url = id.replace(/_/g, ".");
      var permalink = $(this).data("permalink");
      var external = (permalink.indexOf(window.location.hostname) === -1);

      Chrome.addToolbar($(this), id, url, permalink, external);

      var $slideshow = $(this).children(".slideshow").first();

      var slider = new flux.slider($slideshow, {
        autoplay: false,
        transitions: ["slide"]
      });

      $slideshow.click(function() {
        if(external) {
          window.open(permalink, id+"_window");
        }
        else {
          window.location.href = permalink;
        }
      });

      $(this).find(".next").click(function(e) {
        e.preventDefault();
        slider.next("slide");
      });

      $(this).find(".prev").click(function(e) {
        e.preventDefault();
        slider.prev("slide");
      });

      $(this).children(".toolbar").submit(Chrome.onSubmit);

      $(this).removeClass("hidden");
    });

    $(".chrome:first, .chrome:nth-of-type(2)").hover(Chrome.onHover);
  }
};

$(function() {
  if(Viewport.getWidth() === "wide") {
    $("body#home #status p:last").append(" Check&nbsp;out some of my recent work below!");
    $(".chrome").addClass("hidden");

    //link images in the same gallery together
    $(".gallery a").each(function() {
      var offset = $(this).parent().offset();
      var id = offset.top + offset.left;
      $(this).attr("rel", "prettyPhoto[" + id + "]");
    });

    $("a[rel^='prettyPhoto']").prettyPhoto({
      social_tools: ""
    });
  }

  FluidVideos.init();
  $('pre code').each(function(i, e){ hljs.highlightBlock(e, '  ') });
});

$(window).load(function() {
  if(Viewport.getWidth() === "wide") {
    Chrome.init();
  }
});
