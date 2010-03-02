<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Upload</title>
    <link rel="stylesheet" href="Scripts/uploadify/uploadify.css" type="text/css" media="screen" />
    <script type="text/javascript" src="Scripts/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="Scripts/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#fileInput4').fileUpload({
                'uploader': '/Scripts/uploadify/uploader.swf',
                'script': '/home/uploadfile',
                'cancelImg': '/Scripts/uploadify/cancel.png',
                'folder': '/Files',
                'buttonImg': '/Scripts/uploadify/browse-files.png',
                'wmode': 'transparent',
                'width': 130,
                'scriptData': {'Path' : 'Test'},
                'auto': true
            });

            $('#fileInput1').fileUpload({
                'uploader': '/Scripts/uploadify/uploader.swf',
                'script': '/home/uploadfile',
                'cancelImg': '/Scripts/uploadify/cancel.png',
                'folder': '/Files'
            });
        });
    </script>

    <style type="text/css">
    div.demo {background-color:#FFFFFF;
border:1px solid #E5E5E5;
margin-bottom:20px;
padding:20px;}
    </style>
</head>
<body>
    <div class="demo">
        <p><strong>Single File Upload - Custom Button</strong></p>
        <input type="file" id="fileInput4" name="fileInput4" />
    </div>
    
    <div class="demo"> 
<p><strong>Single File Upload</strong></p> 
<input type="file" id="fileInput1" name="fileInput1" /> 
  <br /> 
  <a href="javascript:$('#fileInput1').fileUploadStart();">Upload Files</a> 
</div> 

<form id="myUpload" action="/Home/UploadFile" method="post" enctype="multipart/form-data">
       <input type="file" name="upfile" /> 
       <input type ="submit"  name ="upload" value ="上傳" /> 
</form>

</body>
</html>
