 // Stole'n'hacked JS code from twily.info //

var $=function(id) { return document.getElementById(id); };

var menu=[ // Menu titles
    "Everyday",                                                                 // mnu_2
    "4chan",                                                                    // mnu_3
    "Entertainment",                                                            // mnu_4
    "Theme",                                                                    // mnu_5
    "Other",                                                                    // mnu_6
];


var links=[
    ["Gmail",                           "https://gmail.com",                        "https://www.google.com/gmail/about/images/favicon.ico"],
    ["Aftonbladet",                     "http://aftonbladet.se",                    ""],
    ["Blocket",                         "https://blocket.se",                       ""],
    ["Github",                          "https://github.com",                       ""],
    ["", "", ""],

    ["/b/ - Random",                    "https://boards.4chan.org/b/catalog",       ""],
    ["/diy/ - Do It Yourself",          "https://boards.4chan.org/diy/catalog",     "http://s.4cdn.org/image/favicon-ws.ico"],
    ["/e/ - Ecchi",                     "https://boards.4chan.org/e/catalog",       ""],
    ["", "", ""],

    ["Failblog",                        "http://failblog.cheezburger.com/",         ""],
    ["I Am Bored",                      "http://www.i-am-bored.com/",               "http://www.i-am-bored.com/wp-content/uploads/2015/07/favicon.ico"],
    ["Imgur",                           "https://imgur.com/",                       ""],
    ["9gag",                            "https://9gag.com/trending",                ""],
    ["", "", ""],

    ["Wallhalla",                       "https://wallhalla.com/",                   ""],
    ["Wallhaven",                       "https://alpha.wallhaven.cc/",              ""],
    ["", "", ""],

    ["DeviantArt",                      "http://deviantart.com/",                   ""],
];

var showFavicon=true;
var i,ss="";
function init() {
    build();
}

function build() {
    $('mnu').innerHTML="";
    for(i=0;i<menu.length;i++) {
        $('mnu').innerHTML+="<li>"+menu[i]+"<ul><div id=\"mnu_"+(i+1)+"\"></div></ul></li>";
    }
    var m=1,skip=false;
    for(i=0;i<links.length;i++) {
        if(links[i][0]==""    && links[i][1]=="")    skip=true;
        if(!skip) {
            var printimg="";
            if(showFavicon) {
                var favicon;
                if(links[i][2]!="") favicon=links[i][2];
                else                favicon=getFavicon(links[i][1]);
                printimg="<div class=\"icon\"><img src=\""+favicon+"\""+" onload=\"javascript:this.style.visibility='inherit';\" /></div> ";
            }
            $('mnu_'+m).innerHTML+="<li><a href=\""+links[i][1]+"\" target=\"_blank\">"+printimg+links[i][0]+"</a></li>";
        } else {
            m++;
            skip=false;
        }
    }
}

function getFavicon(url) {
    var l=document.createElement("a");
    l.href=url;
    return l.protocol+"//"+l.hostname+"/favicon.ico";
}
