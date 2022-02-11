/* JS Document */

/******************************

[Table of Contents]

1. Vars and Inits
2. Set Header
3. Init Search
4. Init Menu
5. Init Language Slider
6. Init Timer


******************************/

$(document).ready(function()
{
	"use strict";

	$('input[id=date]').daterangepicker({
		singleDatePicker: true,
    showDropdowns: true,
    minYear: 2019
	});

	$('.select2').select2();


	(function($){
		$('.dropdown-menu a.dropdown-toggle').on('click', function(e) {
			if (!$(this).next().hasClass('show')) {
			$(this).parents('.dropdown-menu').first().find('.show').removeClass("show");
			}
			var $subMenu = $(this).next(".dropdown-menu");
			$subMenu.toggleClass('show');

			$(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function(e) {
			$('.dropdown-submenu .show').removeClass("show");
			});

			return false;
		});
		})(jQuery)

	/*

	1. Vars and Inits

	*/

	var menu = $('.menu');
	var header = $('.header');
	var menuActive = false;
	var burger = $('.hamburger');

	setHeader();

	$(window).on('resize', function()
	{
		setHeader();
	});

	$(document).on('scroll', function()
	{
		setHeader();
	});

	initSearch();
	initMenu();
	initTimer();
	initTabs();

	$('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle-second="tooltip"]').tooltip();


	/*

	2. Set Header

	*/

	function setHeader()
	{
		if($(window).scrollTop() > 100)
		{
			$('.logo-header').addClass('scrolled');
			header.addClass('scrolled');
		}
		else
		{
			$('.logo-header').removeClass('scrolled');
			header.removeClass('scrolled');
		}
	}

	/*

	3. Init Search

	*/

	function initSearch()
	{
		if($('.search_button').length)
		{
			var search = $('.search_button');
			search.on('click', function()
			{
				$('.search_form_container').toggleClass('active');
			});
		}
	}

	/*

	4. Init Menu

	*/

	function initMenu()
	{
		if($('.menu').length)
		{
			var menu = $('.menu');
			if($('.hamburger').length)
			{
				burger.on('click', function()
				{
					if(menuActive)
					{
						closeMenu();
					}
					else
					{
						openMenu();

						$(document).one('click', function cls(e)
						{
							if($(e.target).hasClass('menu_mm'))
							{
								$(document).one('click', cls);
							}
							else
							{
								closeMenu();
							}
						});
					}
				});
			}
		}
	}

	function openMenu()
	{
		menu.addClass('active');
		menuActive = true;
	}

	function closeMenu()
	{
		menu.removeClass('active');
		menuActive = false;
	}

	/*

	6. Init Timer

	*/

	function initTimer()
	{
		if($('.timer_list').length)
    	{
    		// Uncomment line below and replace date
	    	var target_date = new Date("November 25, 2020 00:00:00").getTime();

	    	// comment lines below
	    	// var date = new Date();
	    	// date.setDate(date.getDate() + 21);
	    	// var target_date = date.getTime();
	    	//----------------------------------------

			// variables for time units
			var days, hours, minutes, seconds;

			var d = $('#day');
			var h = $('#hour');
			var m = $('#minute');
			var s = $('#second');

			setInterval(function ()
			{
			    // find the amount of "seconds" between now and target
			    var current_date = new Date().getTime();
			    var seconds_left = (target_date - current_date) / 1000;

			    // do some time calculations
			    days = parseInt(seconds_left / 86400);
			    seconds_left = seconds_left % 86400;

			    hours = parseInt(seconds_left / 3600);
			    seconds_left = seconds_left % 3600;

			    minutes = parseInt(seconds_left / 60);
			    seconds = parseInt(seconds_left % 60);

			    // display result
			    d.text(days);
			    h.text(hours);
			    m.text(minutes);
			    s.text(seconds);

			}, 1000);
    	}
	}

	function initTabs()
	{
		if($('.tab').length)
		{
			$('.tab').on('click', function()
			{
				$('.tab').removeClass('active');
				$(this).addClass('active');
				var clickedIndex = $('.tab').index(this);

				var panels = $('.tab_panel');
				panels.removeClass('active');
				$(panels[clickedIndex]).addClass('active');
			});
		}
	}

});

function myFunction() {
	var dots = document.getElementById("dots");
	var moreText = document.getElementById("more");
	var btnText = document.getElementById("myBtn");
  
	if (dots.style.display === "none") {
	  dots.style.display = "inline";
	  btnText.innerHTML = "View more";
	  moreText.style.display = "none";
	} else {
	  dots.style.display = "none";
	  btnText.innerHTML = "View less";
	  moreText.style.display = "inline";
	}
  }

  var defaultTheme = getRandom(4);

var today = new Date();

var events = [ {
    id: "imwyx6S",
    name: "Event #3",
    description: "Lorem ipsum dolor sit amet.",
    date: today.getMonth() + 1 + "/18/" + today.getFullYear(),
    type: "event"
}, {
    id: "9jU6g6f",
    name: "Holiday #1",
    description: "Lorem ipsum dolor sit amet.",
    date: today.getMonth() + 1 + "/10/" + today.getFullYear(),
    type: "holiday"
}, {
    id: "0g5G6ja",
    name: "Event #1",
    description: "Lorem ipsum dolor sit amet.",
    date: [ today.getMonth() + 1 + "/2/" + today.getFullYear(), today.getMonth() + 1 + "/5/" + today.getFullYear() ],
    type: "event",
    everyYear: !0
}, {
    id: "y2u7UaF",
    name: "Holiday #3",
    description: "Lorem ipsum dolor sit amet.",
    date: today.getMonth() + 1 + "/23/" + today.getFullYear(),
    type: "holiday"
}, {
    id: "dsu7HUc",
    name: "Birthday #1",
    description: "Lorem ipsum dolor sit amet.",
    date: new Date(),
    type: "birthday"
}, {
    id: "dsu7HUc",
    name: "Birthday #2",
    description: "Lorem ipsum dolor sit amet.",
    date: today.getMonth() + 1 + "/27/" + today.getFullYear(),
    type: "birthday"
} ];

var active_events = [];

var week_date = [];

var curAdd, curRmv;

function getRandom(a) {
    return Math.floor(Math.random() * a);
}

function getWeeksInMonth(a, b) {
    var c = [], d = new Date(b, a, 1), e = new Date(b, a + 1, 0), f = e.getDate();
    var g = 1;
    var h = 7 - d.getDay();
    while (g <= f) {
        c.push({
            start: g,
            end: h
        });
        g = h + 1;
        h += 7;
        if (h > f) h = f;
    }
    return c;
}

week_date = getWeeksInMonth(today.getMonth(), today.getFullYear())[2];

$(document).ready(function() {
    $("#demoEvoCalendar").evoCalendar({
        format: "MM dd, yyyy",
        titleFormat: "MM",
        calendarEvents: [{
          id: "abc",
          name: "Event",
          description: "Hari Keluarga Nasional",
          date: "June/29/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "UNFPA Web Series: Kesehatan Ibu Keluarga Berencana Keren untuk Cegah Kematian Ibu dan Stunting",
          date: "June/25/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "Hari Bidan Internasional",
          date: "May/5/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "UNPA Web Series: Kesehatan Ibu Peringatan Hari Bidan Internasional 2021",
          date: "May/25/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "Hari Kartini",
          date: "April/21/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "UNFPA Web Series: Kesehatan Ibu Kematian Ibu di Indonesia Riwayatmu Dulu Hingga Kini",
          date: "April/30/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "Pertemuan Ilmiah Keluarga Berencana dan Kesehatan Reproduksi",
          date: "June/28/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "Pertemuan Ilmiah Keluarga Berencana dan Kesehatan Reproduksi",
          date: "June/29/2021",
          type: "event",
        }, {
          id: "abc",
          name: "Event",
          description: "Pertemuan Ilmiah Keluarga Berencana dan Kesehatan Reproduksi",
          date: "June/30/2021",
          type: "event",
        }
        ]
    });
    $("[data-set-theme]").click(function(b) {
        a(b.target);
    });
    $("#addBtn").click(function(a) {
        curAdd = getRandom(events.length);
        $("#demoEvoCalendar").evoCalendar("addCalendarEvent", events[curAdd]);
        active_events.push(events[curAdd]);
        events.splice(curAdd, 1);
        if (0 === events.length) a.target.disabled = !0;
        if (active_events.length > 0) $("#removeBtn").prop("disabled", !1);
    });
    $("#removeBtn").click(function(a) {
        curRmv = getRandom(active_events.length);
        $("#demoEvoCalendar").evoCalendar("removeCalendarEvent", active_events[curRmv].id);
        events.push(active_events[curRmv]);
        active_events.splice(curRmv, 1);
        if (0 === active_events.length) a.target.disabled = !0;
        if (events.length > 0) $("#addBtn").prop("disabled", !1);
    });
    a($("[data-set-theme]")[defaultTheme]);
    function a(a) {
        var b = a.dataset.setTheme;
        $("[data-set-theme]").removeClass("active");
        $(a).addClass("active");
        $("#demoEvoCalendar").evoCalendar("setTheme", b);
    }
    var b = getRandom($("[data-settings]").length);
    var c = $("[data-settings]")[b];
    var d = getRandom($("[data-method]").length);
    var e = $("[data-method]")[d];
    var f = getRandom($("[data-event]").length);
    var g = $("[data-event]")[f];
    showSettingsSample($(c).data().settings);
    showMethodSample($(e).data().method);
    showEventSample($(g).data().event);
    $("[data-settings]").on("click", function(a) {
        var b = $(a.target).closest("[data-settings]");
        var c = b.data().settings;
        showSettingsSample(c);
    });
    $("[data-method]").on("click", function(a) {
        var b = $(a.target).closest("[data-method]");
        var c = b.data().method;
        showMethodSample(c);
    });
    $("[data-event]").on("click", function(a) {
        var b = $(a.target).closest("[data-event]");
        var c = b.data().event;
        showEventSample(c);
    });
});

function showSettingsSample(a) {
    var b = $("#event-settings");
    var c;
    switch (a) {
      case "theme":
        c = '<br><span class="green">// theme</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'theme'</span>: <span class=\"red\">'Theme Name'</span><br>" + "});" + "<br> ";
        break;

      case "language":
        c = '<br><span class="green">// language</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'language'</span>: <span class=\"red\">'en'</span><br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// Supported language: en, es, de..</span><br>' + "});" + "<br> ";
        break;

      case "format":
        c = '<br><span class="green">// format</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'format'</span>: <span class=\"red\">'MM dd, yyyy'</span><br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// some browsers doesn\'t support other format, so...</span><br>' + "});" + "<br> ";
        break;

      case "titleFormat":
        c = '<br><span class="green">// titleFormat</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'titleFormat'</span>: <span class=\"red\">'MM'</span><br>" + "});" + "<br> ";
        break;

      case "eventHeaderFormat":
        c = '<br><span class="green">// eventHeaderFormat</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'eventHeaderFormat'</span>: <span class=\"red\">'MM dd'</span><br>" + "});" + "<br> ";
        break;

      case "firstDayOfWeek":
        c = '<br><span class="green">// firstDayOfWeek</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'firstDayOfWeek\'</span>: <span class="red">0</span> <span class="green">// Sun</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// 0-6 (Sun-Sat)</span><br>' + "});" + "<br> ";
        break;

      case "todayHighlight":
        c = '<br><span class="green">// todayHighlight</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'todayHighlight\'</span>: <span class="blue">true</span><br>' + "});" + "<br> ";
        break;

      case "sidebarDisplayDefault":
        c = '<br><span class="green">// sidebarDisplayDefault</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'sidebarDisplayDefault\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
        break;

      case "sidebarToggler":
        c = '<br><span class="green">// sidebarToggler</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'sidebarToggler\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
        break;

      case "eventDisplayDefault":
        c = '<br><span class="green">// eventDisplayDefault</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'eventDisplayDefault\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
        break;

      case "eventListToggler":
        c = '<br><span class="green">// eventListToggler</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>({<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="violet">\'eventListToggler\'</span>: <span class="blue">false</span><br>' + "});" + "<br> ";
        break;

      case "calendarEvents":
        c = '<br><span class="green">// calendarEvents</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'calendarEvents\'</span>, {<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;<span class=\"violet\">'calendarEvents'</span>: [<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'4hducye\'</span>, <span class="green">// Event\'s id (required, for removing event)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">description</span>: <span class="red">\'Lorem ipsum dolor sit amet..\'</span>, <span class="green">// Description of event (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">badge</span>: <span class="red">\'1-day event\'</span>, <span class="green">// Event badge (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="blue">new</span> <span class="yellow">Date</span>(), <span class="green">// Date of event</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'holiday\'</span>, <span class="green">// Type of event (event|holiday|birthday)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">color</span>: <span class="red">\'#63d867\'</span>, <span class="green">// Event custom color (optional)</span><br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">everyYear</span>: <span class="blue">true</span> <span class="green">// Event is every year (optional)</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;}<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;]<br>" + "});" + "<br> ";
    }
    $("[data-settings]").removeClass("active");
    $('[data-settings="' + a + '"]').addClass("active");
    b.html(c);
}

function showMethodSample(a) {
    var b = $("#method-code");
    var c;
    switch (a) {
      case "setTheme":
        c = '<br><span class="green">// setTheme</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'setTheme\'</span>, <span class="red">\'Theme Name\'</span>);' + "<br> ";
        break;

      case "toggleSidebar":
        c = '<br><span class="green">// toggleSidebar</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleSidebar\'</span>);' + "<br> " + '<br><span class="green">// open sidebar</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleSidebar\'</span>, <span class="blue">true</span>);' + "<br> ";
        break;

      case "toggleEventList":
        c = '<br><span class="green">// toggleEventList</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleEventList\'</span>);' + "<br> " + '<br><span class="green">// close event list</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'toggleEventList\'</span>, <span class="blue">false</span>);' + "<br> ";
        break;

      case "getActiveDate":
        c = '<br><span class="green">// getActiveDate</span><br>' + '<span class="red">var</span> <span class="orange">active_date</span> = $(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'getActiveDate\'</span>);' + "<br> ";
        break;

      case "getActiveEvents":
        c = '<br><span class="green">// getActiveEvents</span><br>' + '<span class="red">var</span> <span class="orange">active_events</span> = $(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'getActiveEvents\'</span>);' + "<br> ";
        break;

      case "selectYear":
        c = '<br><span class="green">// selectYear</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectYear\'</span>, <span class="red">2021</span>);' + "<br> ";
        break;

      case "selectMonth":
        c = '<br><span class="green">// selectMonth</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectMonth\'</span>, <span class="red">1</span>); <span class="green">// february</span>' + "<br> ";
        break;

      case "selectDate":
        c = '<br><span class="green">// selectDate</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'selectDate\'</span>, <span class="red">\'February 15, 2020\'</span>);' + "<br> ";
        break;

      case "addCalendarEvent":
        c = '<br><span class="green">// addCalendarEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'addCalendarEvent\'</span>, {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'kNybja6\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Mom\\\'s Birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">description</span>: <span class="red">\'Lorem ipsum dolor sit..\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'May 27, 2020\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'birthday\'</span><br>' + "});" + '<br><span class="green">// add multiple events</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'addCalendarEvent\'</span>, [<br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'kNybja6\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Mom\\\'s Birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'May 27, 1965\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'birthday\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">everyYear</span>: <span class="blue">true</span> <span class="green">// optional</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;},<br>" + "&#8194;&#8194;&#8194;&#8194;&#8194;{<br>" + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">id</span>: <span class="red">\'asDf87L\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">name</span>: <span class="red">\'Graduation Day!\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">date</span>: <span class="red">\'March 21, 2020\'</span>,<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;&#8194;<span class="blue">type</span>: <span class="red">\'event\'</span><br>' + "&#8194;&#8194;&#8194;&#8194;&#8194;}<br>" + "]);" + "<br> ";
        break;

      case "removeCalendarEvent":
        c = '<br><span class="green">// removeCalendarEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'removeCalendarEvent\'</span>, <span class="red">\'kNybja6\'</span>);' + "<br> " + '<br><span class="green">// delete multiple event</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'removeCalendarEvent\'</span>, [<span class="red">\'kNybja6\'</span>, <span class="red">\'asDf87L\'</span>]);' + "<br> ";
        break;

      case "destroy":
        c = '<br><span class="green">// destroy</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">evoCalendar</span>(<span class="violet">\'destroy\'</span>);' + "<br> ";
    }
    $("[data-method]").removeClass("active");
    $('[data-method="' + a + '"]').addClass("active");
    b.html(c);
}

function showEventSample(a) {
    var b = $("#event-code");
    var c;
    switch (a) {
      case "selectDate":
        c = '<br><span class="green">// selectDate</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectDate\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">newDate</span>, <span class="yellow">oldDate</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
        break;

      case "selectEvent":
        c = '<br><span class="green">// selectEvent</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectEvent\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeEvent</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
        break;

      case "selectMonth":
        c = '<br><span class="green">// selectMonth</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectMonth\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeMonth</span>, <span class="yellow">monthIndex</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
        break;

      case "selectYear":
        c = '<br><span class="green">// selectYear</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'selectYear\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">activeYear</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
        break;

      case "destroy":
        c = '<br><span class="green">// destroy</span><br>' + '$(<span class="red">\'#calendar\'</span>).<span class="yellow">on</span>(<span class="violet">\'destroy\'</span>, <span class="blue">function</span>(<span class="yellow">event</span>, <span class="yellow">evoCalendar</span>) {<br>' + '&#8194;&#8194;&#8194;&#8194;&#8194;<span class="green">// code here...</span><br>' + "});" + "<br> ";
    }
    $("[data-event]").removeClass("active");
    $('[data-event="' + a + '"]').addClass("active");
    b.html(c);
}

$('[data-go*="#"]').on("click", function(a) {
    a.preventDefault();
    var b = $(this).data().go;
    if ("#top" === b) {
        $("html, body").animate({
            scrollTop: 0
        }, 500);
        return;
    } else var c = $(b)[0].offsetTop - $("header")[0].offsetHeight - 10;
    $("html, body").animate({
        scrollTop: c
    }, 500);
});