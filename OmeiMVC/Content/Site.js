
function openwin(pageUrl, winName, width, height) {
    window.open(pageUrl, winName, "height=" + height + ", width=" + width + ", toolbar=yes, menubar=no, resizable=yes, location=no, scrollbars=yes, status=no")
}

function openBareWin(pageUrl, winName, width, height) {
    window.open(pageUrl, winName, "height=" + height + ", width=" + width + ", toolbar=no, menubar=no, resizable=yes, location=no, scrollbars=yes, status=no")
}