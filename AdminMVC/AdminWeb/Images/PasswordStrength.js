// JScript File

  ratingMsgs = new Array(6);
  ratingMsgColors = new Array(6);
  barColors = new Array(6);

  ratingMsgs[0] = "太短";
  ratingMsgs[1] = "弱";
  ratingMsgs[2] = "一般";
  ratingMsgs[3] = "很好";
  ratingMsgs[4] = "极佳";
  ratingMsgs[5] = "未评级"; 

  ratingMsgColors[0] = "#676767";
  ratingMsgColors[1] = "#aa0033";
  ratingMsgColors[2] = "#f5ac00";
  ratingMsgColors[3] = "#6699cc";
  ratingMsgColors[4] = "#008000";
  ratingMsgColors[5] = "#676767";

  barColors[0] = "#dddddd";
  barColors[1] = "#aa0033";
  barColors[2] = "#ffcc33";
  barColors[3] = "#6699cc";
  barColors[4] = "#008000";
  barColors[5] = "#676767";
	
	
	var minpwlength = 4;
	var fairpwlength = 7;
	
	var STRENGTH_SHORT = 0;  // less than minpwlength 
	var STRENGTH_WEAK = 1;  // less than fairpwlength
	var STRENGTH_FAIR = 2;  // fairpwlength or over, no numbers
	var STRENGTH_STRONG = 3; // fairpwlength or over with at least one number
	
	var strengthlevel = 0;
	
	function updatestrength( pw ) {
		if( istoosmall( pw ) ) {
			strengthlevel = STRENGTH_SHORT;
		}
		else if( !isfair( pw ) ) { 
			strengthlevel = STRENGTH_WEAK;
		}	
		else if( hasnum( pw ) ) {
			strengthlevel = STRENGTH_STRONG;
		}
		else {
			strengthlevel = STRENGTH_FAIR;
		}
		DrawBar(strengthlevel);
	}
	
	function isfair( pw ) {
		if( pw.length < fairpwlength ) {
			return false;
		}
		else { 
			return true;
		}
	}
	
	function istoosmall( pw ) {
		if( pw.length < minpwlength ) {
			return true;
		}
		else {
			return false;
		}
	}
	
	function hasnum( pw ) {
		var hasnum = false;
		for( var counter = 0; counter < pw.length; counter ++ ) {
			if( !isNaN( pw.charAt( counter ) ) ) {
				hasnum = true;
			}
		}
		return hasnum;
	}
function getElement(name) {
  if (document.all) {
	  return document.all(name);
  }
  return document.getElementById(name);
}
  
function DrawBar(rating) {
  var posbar = getElement('posBar');
  var negbar = getElement('negBar');
  var passwdRating = getElement('passwdRating');
  var barLength = getElement('passwdBarDiv').width;
  if (rating >2 ) rating = rating + 1;
  if (rating >= 0 && rating <= 4) {  
      posbar.style.width = barLength / 4 * rating;
      negbar.style.width = barLength / 4 * (4 - rating);
    } else {
      posbar.style.width = 0;
      negbar.style.width = barLength;
      rating = 5; 
    }
    posbar.style.background = barColors[rating];
    passwdRating.innerHTML = "<font color='" + ratingMsgColors[rating] +
                             "'>" + ratingMsgs[rating] + "</font>";
  }