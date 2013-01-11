// ==UserScript==
// @name        gc-cleaner
// @namespace   gc-cleaner
// @include     https://code.google.com/p/lightpack/wiki
// @version     1
// @grant       GM_xmlhttpRequest
// ==/UserScript==

var $ = function(id) { 
    return document.getElementById(id);
}

function trim(s) {
    return s.replace(/^\s+|\s+$/g,'');  
}


var clist = $('commentlist');
var saw = 1;
var i = 0;

for (i=0; i<clist.children.length; i++) {
    var commentNode = clist.children[i];
    if (commentNode.nodeName == 'DIV' && !commentNode.className.match(/(?:^|\s)delcom(?!\S)/) ) {
        var link = document.createElement('a');
        link.setAttribute('href', '#');
        link.textContent = 'delete all comments above';
        link.addEventListener('click', function() { this.saw = saw; return deleteComments(saw) }, false);

        var child = commentNode.children[0]
        child.appendChild(link);

        saw++;
    }
}

function buildGetParams(params) {
    var s='';
    for (var key in params) {
        s = s + key + '=' + encodeURIComponent(params[key]) + '&';
    }
    return s;
}


function deleteComment(cid, time, params) {
    params['sequence_num'] = cid;
    params['create_time'] = time;

    GM_xmlhttpRequest({
        method: "POST",
        url   : 'https://code.google.com/p/lightpack/w/delComment.do',
        data  : buildGetParams(params),
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        }
    });

}

function deleteComments(num) {

    var delcom = document.getElementsByName('delcom')[0];
    var params = { 'token'   : delcom.children[4].value,
                   'pagename': delcom.children[3].value,
                   'mode'    : '1',
                   'sequence_num': '',
                   'create_time': '' };


    var clist = $('commentlist');
    var deleted = 0;
    var i = 0;
    while (deleted < num) {
        var commentNode = clist.children[i];
        if (commentNode.nodeName == 'DIV' && !commentNode.className.match(/(?:^|\s)delcom(?!\S)/) ) {
            var onclick = commentNode.children[0].children[0].getAttribute('onclick');
            var start = onclick.indexOf('(')+1;
            var a = onclick.substr(start, onclick.length - start - 1).split(',');
            var idStr = trim(a[0]);
            var timeStr = trim(a[1]);
            var id = idStr.substr(1, idStr.length-2);
            var time = timeStr.substr(1, timeStr.length-2);
            deleteComment(id,time,params);
    //        eventFire(a, 'click');
            deleted++;
        }
        i++;
    }
    return false;
}

link.addEventListener('click', deleteComments, false);
