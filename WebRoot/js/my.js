$(document).ready(function () {
            var browser = {
                versions: function() {
                    var u = navigator.userAgent,
                        app = navigator.appVersion;
                    return {
                        mobile: !!u.match(/AppleWebKit.*Mobile.*/),
                        ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
                        android: u.indexOf("Android") > -1 || u.indexOf("Linux") > -1,
                        iPhone: u.indexOf("iPhone") > -1,
                        iPad: u.indexOf("iPad") > -1
                    };
                } (),
                language: (navigator.browserLanguage || navigator.language).toLowerCase()
            };
            console.info("是否为移动终端: " + browser.versions.mobile);
            console.info("是否 ios: " + browser.versions.ios);
            console.info("是否 android: " + browser.versions.android);
            if(browser.versions.mobile || browser.versions.ios || browser.versions.android){
				$("p[type=ticket1]").css({"font-size":"5vw","padding-top": "15%"});
				$("p[type=ticket2]").css({"font-size":"3vw"});
				$("video").css({"width":"100%","height":"56.25%"});
				$("video").attr("poster","../images/20170314155425.png");
            }
        });