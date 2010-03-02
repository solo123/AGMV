// JScript File
var editPage
function itemClick(refUrl){
    //location.replace(refUrl);  //no history back
    location.href = refUrl;
}

function mhHover(tbl,idx,cls){
	var t,d;
	if(document.getElementById)
		t=document.getElementById(tbl);
	else 
		t=document.all(tbl);
		
	if(t==null) return;
	
	if(t.getElementsByTagName)
		d=t.getElementsByTagName("TD");
	else 
		d=t.all.tags("TD");
		
	if(d==null) return;
	
	if(d.length<=idx) return;
	d[idx].className=cls;
}
function MenuOnClick(menuPara)
{
    __doPostBack('', menuPara); 
}

/*
   return Selected seats number split by , eg: 2,3,4
   if any error, format as: ERR:0
*/
function GetSelectedSeats(ptn)
{
    var cbs = document.getElementsByName("cb");
    if ( cbs.length==0 )
        return "";

    var s = "";
    for ( i=0; i<cbs.length; i++)
    {
        if ( cbs[i].checked )
        {
            if (ptn!=null && ptn!="")
            {
                if ( ptn.indexOf(cbs[i].value)==-1 )
                    return "ERR:0";
            }
            s = s + i + ', ';
        }
    }
    if ( s.length > 2 )
        s = s.substring(0, s.length-2 );
    
    return s;
}

function viewUserInfo(userId)
{
    if ( userId>0 )
    {
        window.open("UserInfo_pop.aspx?ro=1&id=" + userId, "CustomerInfoWin", "dependent=yes, height=300, width=600, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no", true );
    }
}


function enter(sender) 
{
    if(window.event && window.event.keyCode == 13) 
    {
        if (sender!=null)
        {
            if(sender.id=="txtOrderID") QuickGoOrder();
            if(sender.id=="txtScheduleID") QuickGoSchedule();
            if(sender.id=="txtSearchUser" ) QuickGoSearchUser();
        }
        return false; 
    } else
        return true;
}

function QuickGoOrder()
{
    QuickGo("OrderDetail.aspx", "txtOrderID");
}
function QuickGoSchedule()
{
    QuickGo("BusSeats.aspx", "txtScheduleID");
}
function QuickGoSearchUser(){
    QuickGo("SearchCustomer.aspx", "txtSearchUser");
}
function QuickGo(pageUrl, txtId)
{
    var t = document.getElementById(txtId);
    if ( t ==null ) return;
    
    if ( t.value=="" ) 
        t.focus();
    else {
        location = pageUrl + "?id=" + t.value;
        t.select();
    }
}

//------list checkbox process---------
function ChangeCheckBoxState(id, checkState)
{
    var cb = document.getElementById(id);
    if (cb != null)
        cb.checked = checkState;
}

var CheckBoxIDs = null;
function ChangeAllCheckBoxStates(checkState)
{
  // Toggles through all of the checkboxes defined in the CheckBoxIDs array
  // and updates their value to the checkState input parameter
  if (CheckBoxIDs != null)
  {
     for (var i = 0; i < CheckBoxIDs.length; i++)
        ChangeCheckBoxState(CheckBoxIDs[i], checkState);
  }
}

function openWindow(_sUrl, _sWidth, _sHeight, _sTitle, _sScroll)
{
    var oEdit = new dialog();
    oEdit.init();
    oEdit.set('title', _sTitle ? _sTitle : "系统提示信息" );
    oEdit.set('width', _sWidth);
    oEdit.set('height', _sHeight);
    oEdit.open(_sUrl, _sScroll ? 'no' : 'yes');
}

function cfm(msg){
    if( confirm(msg)==false){
        window.event.returnValue = false;
        window.event.cancelBubble = true;
        return false;
    }
    return true;
}
