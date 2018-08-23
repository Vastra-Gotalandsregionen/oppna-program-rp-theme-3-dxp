// Flex-box Fixes

// Init Flex-box fix
;( function( $, window, document, undefined ) {
  'use strict';

  var s = document.body || document.documentElement, s = s.style;
  if( s.webkitFlexWrap == '' || s.msFlexWrap == '' || s.flexWrap == '' ) {
    return true;
  }

  var flexUsages = [];

  // Teaser blocks
  var teaserBlocks = $('.teaser-blocks');
  teaserBlocks.each(function() {
    var wrapper = $(this);
    var items = $(this).find('.teaser-block');

    flexUsages.push({
      wrapper: wrapper,
      items: items
    });
  });

  setFlexHeights(flexUsages);

  $( window ).on( 'resize', function() {
    setFlexHeights(flexUsages);
  });

  $.each(flexUsages, function() {
    this.items.find('img').on('load', function() {
    setFlexHeights(flexUsages);
    });
  });


})( jQuery, window, document );

// Admin bar toggle
;( function( $, window, document, undefined ) {
  'use strict';

  var elListToggleControls = $('.toggle-controls');
	if (elListToggleControls.length === 1) {
		$(elListToggleControls[0]).removeClass('visible-xs');
	}

  var elBody = $('body');
  var elAddPanel = $('.lfr-add-panel');
  var elProductMenu = $('.lfr-product-menu-panel');
  var elToggleButton = $('.js-toggle-admin-mode');

  // No product menu exists
  if(!elProductMenu) {
    return;
  }

  if(elBody.hasClass('custom-admin-controls-closed')) {
    elBody.removeClass('open');
    elBody.addClass('closed');

    elProductMenu.removeClass('open');
    elProductMenu.addClass('closed');
  }

  elToggleButton.addClass('show');

  elToggleButton.on('click', toggleControlMenu);

  function toggleControlMenu() {
    var elBody = $('body');

    if(elBody.hasClass('custom-admin-controls-closed')) {
      Liferay.Store('custom_admin_controls', 'custom-admin-controls-open');
      elBody.removeClass('custom-admin-controls-closed');
      elBody.addClass('custom-admin-controls-open');
    } else if(elBody.hasClass('custom-admin-controls-open')) {
      Liferay.Store('custom_admin_controls', 'custom-admin-controls-closed');
      elBody.removeClass('custom-admin-controls-open');
      elBody.addClass('custom-admin-controls-closed');
    }

  }



})( jQuery, window, document );

function setFlexHeights (flexUsages) {

  $.each(flexUsages, function() {
    setFlexHeight(this.wrapper, this.items);
  });

}

function setFlexHeight (wrapper, items) {
     items.css( 'height', 'auto' );

     var perRow = Math.floor( wrapper.width() / items.width() );
     if( perRow == null || perRow < 2 ) return true;

     for( var i = 0, j = items.length; i < j; i += perRow ) {
       var maxHeight   = 0;
       var row = items.slice( i, i + perRow );

       row.each(function() {
         var itemHeight = parseInt( $( this ).outerHeight() );
         if ( itemHeight > maxHeight ) {
           maxHeight = itemHeight;
         }
       });

       row.css( 'height', maxHeight );
     }
};


// Sticky Navigation
initStickyNavigation();

function initStickyNavigation() {
  var navWrapper = $('.navigation-wrapper');
  var navScrolledCssClass = 'navigation-wrapper-scrolled';
  var scrollHeightLimit = $('.banner-nav').height();
  scrollHeightLimit = scrollHeightLimit*0.7;


  $(window).scroll(function() {
    if( $(this).scrollTop() > scrollHeightLimit ) {
      navWrapper.addClass(navScrolledCssClass);
    } else {
      navWrapper.removeClass(navScrolledCssClass);
    }
  });
}

// Maps
/*
var geocoder = new google.maps.Geocoder();

$('.map-container').each(function(index) {
  var currentElement = $(this);

  var title = currentElement.data('title');
  var streetAddress = currentElement.data('streetaddress');
  var zipCode = currentElement.data('zipcode');
  var city = currentElement.data('city');

  var location = {
    title: currentElement.data('title'),
    streetAddress: currentElement.data('streetaddress'),
    zipCode: currentElement.data('zipcode'),
    city: currentElement.data('city')
  }

  var address = '';
  if(location.title != '') {
    address = address + location.title;
  }
  if(location.streetAddress != '') {
    if(address != '') {
      address = address + ', ';
    }
    address = address + location.streetAddress;
  }
  if(location.zipCode != '') {
    if(address != '') {
      address = address + ', ';
    }
    address = address + location.zipCode;
  }
  if(location.city != '') {
    if(address != '') {
      address = address + ', ';
    }
    address = address + location.city;
  }

  console.log('address:' + address);

  geocoder.geocode({ 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var latLng = results[0].geometry.location;
      renderMap(currentElement, location, latLng);
    }
  });

});


function renderMap(node, location, latLng) {

  var map = new google.maps.Map(node[0], {
      center: latLng,
      mapTypeControl: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      navigationControl: true,
      scaleControl: true,
      streetViewControl: true,
      zoom: 14
  });

  var contentString = '<div>' +
    '<div><strong>' + location.title + '</strong></div>' +
    '<div>' + location.streetAddress + '</div>' +
    '<div>' + location.zipCode + ' ' + location.city + '</div>' +
  '</div>';

  var infoWindow = new google.maps.InfoWindow({
    content: contentString
  });

  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    title: location.title
});

  google.maps.event.addListener(marker, 'click', function() {
    infoWindow.open(map, marker);
  });

  // Launch info window
  infoWindow.open(map, marker);

}

// Hero Carousel
/!*
*!/
var heroCarousel = $('.hero-carousel');
heroCarousel.addClass('owl-carousel');
var heroCarouselWrap = $(heroCarousel).parents('.hero-carousel-wrap')[0];

heroCarousel.owlCarousel({

  items: 1,

  loop:true,
  margin:10,

  nav:true,
  navText : [
    '<i class="icon-chevron-left"><span class="label">Next</span>',
    '<i class="icon-chevron-right"><span class="label">Previous</span>'
  ],

  dots: true,

  //autoplay:true,
  autoplay:false,
  //autoplayTimeout:5000,
  autoplayTimeout:50000000000000000,
  autoplayHoverPause:true,

  singleItem: 1

});

// Bind FAQ
;( function( $, window, document, undefined ) {

  initFAQ();

  function initFAQ() {
    var faqQuestionNodes = $('.faq-question');

    faqQuestionNodes.on('click', onFaqQuestionClick);

    faqQuestionNodes.on('mouseover', function(e) {
      var currentTarget = $(e.currentTarget);
      currentTarget.addClass('hover');
    });
    faqQuestionNodes.on('mouseout', function(e) {
      var currentTarget = $(e.currentTarget);
      currentTarget.removeClass('hover');
    });
  }

  function onFaqQuestionClick(e) {
    var currentTarget = $(e.currentTarget);

    var listNode = currentTarget.closest('li');
    listNode.toggleClass('expanded');
  }


})( jQuery, window, document );
*/
