var strings = [
    "Initialzing request",
    "Resolving internet address a16@b5",
    "Requesting access to server",
    "Entering credentials",
    "Login denied",
    "Re-entering credentials",
    "Access granted",
    "Finding CTF Flag stolen by Tonitruantt",
    "Flag found on dofus services",
    "Starting mcstausd",
    "Starting portmap",
    "Starting dofus",
    "Starting setroubleshootd",
    "Starting RPC idmapd",
    "Starting mdmonitor",
    "Starting system message bus",
    "Starting Bluetooth services",
    "Starting other filesystems",
    "Starting PC/SC smart card daemon (pcscd)",
    "Starting hidden kama on Bisbis account",
    "Enabling /etc/fstab swaps",
    "INIT: Entering runlevel 3",
    "Entering non-interactive startup",
    "Applying INTEL CPU microcode update",
    "Checking for hardware changes",
    "Bringing up interface TchoupaCool",
    "Determining IP information for Tchoupa... done.",
    "Starting mcstausd",
    "Starting gw2",
    "Starting portmap",
    "Starting setroubleshootd",
    "Starting RPC idmapd",
    "Starting mdmonitor",
    "Starting system message bus",
    "Starting Bluetooth services",
    "Starting other filesystems",
    "Starting PC/SC smart card daemon (pcscd)",
    "Starting hidd",
    "Enabling /etc/fstab swaps",
    "INIT: Entering runlevel 3",
    "Entering non-interactive startup",
    "Applying INTEL CPU microcode update",
    "Checking for hardware changes",
    "Bringing up interface eth0",
    "Determining IP information for eth0... done.",
    "Connecting to gw2 service",
    "Connected to gw2 service",
    "Finding Tchoupa gold",
    "Gold found on draconite falls",
    "Establishing connection to inventory",
    "Connection established",
    "Logging into the legendary event",
    "Login successful",
    "Trying to finish boss",
    "Fetching stuff from loot",
    "Gold acquired",
    "Finding other resources",
    "Fetching resources",
    "Processing DOM",
    "Loading images",
    "Loading content",
    "Page rendered",
    "Starting display manager",
    "WELCOME TO TCHOUPA LAND",
    "Initializing..."
  ];
  
  var preloader = document.getElementById('preloader');
  var delay = 1000;
  var count = 0;
  var repeat = 0;
  
  function addLog() {
    var row = createLog('ok', count);
    preloader.appendChild(row);
    
    goScrollToBottom();
    
    count++;
    
    if (repeat == 0) {
      if (count > 3) {
        delay = 300;
      }
      
      if (count > 6) {
        delay = 100;
      }
      
      if (count > 8) {
        delay = 50;
      }
      
      if (count > 10) {
        delay = 10;
      }
    } else {
      if (count > 3) {
        delay = 10;
      }
    }
    
    if (count < strings.length) {
      setTimeout(function() {
        return addLog();
      }, delay);
    } else {
      setTimeout(function() {
        delay = 1000;
        return createLog("ok");
      }, 1000);
    }
  }
  
  function createLog(type, index) {
    var row = document.createElement('div');
    
    var spanStatus = document.createElement('span');
    spanStatus.className = type;
    spanStatus.innerHTML = type.toUpperCase();
    
    var message = (index != null) 
                ? strings[index] 
                : 'kernel: Initializing...';
  
    if(index == null) 
    {
      var preloader = $('#preloader');
      jQuery(preloader).fadeOut("slow");
      jQuery("#main").fadeIn("slow");
    }
    
    var spanMessage = document.createElement('span');
    spanMessage.innerHTML = message;
    
    row.appendChild(spanStatus);
    row.appendChild(spanMessage);
    
    return row;
  }
  
  function goScrollToBottom() {
    $(document).scrollTop($(document).height()); 
  }
  
  function setCookie(cname,cvalue,exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
  }
  
  // below method reference https://stackoverflow.com/questions/5639346/what-is-the-shortest-function-for-reading-a-cookie-by-name-in-javascript/25490531#25490531
  function getCookie(a) {
    var b = document.cookie.match('(^|;)\\s*' + a + '\\s*=\\s*([^;]+)');
    return b ? b.pop() : '';
  }
  
  function checkCookie() {
    var user=getCookie("visited"); 
    if (user == 1) {   
      setCookie("visited", 1, 30); //this will update the cookie      
      jQuery("#main").fadeIn("slow"); 
    } else {  
      addLog();      
      setCookie("visited", 1, 30);   
  
    }
  }
  
  checkCookie();