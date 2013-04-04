<html>
<head>
  <title>Chask</title>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
  <script src="https://apps.imoapi.com/imo.im/api/2/imoapi-min.js"></script>
  <script src="js/chat_example.js"></script>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
  <link rel="stylesheet" type="text/css" href="css/custom.css" />
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <link href='http://fonts.googleapis.com/css?family=Raleway:200,400' rel='stylesheet' type='text/css'>

</head>

<body>

  <div id="start">

        <img src="logo.png" />

        <h3>Chat and manage tasks... all from one little box</h3>

        <h2>You're in the <span class="group"></span> group</h2>

          <form id="name_form">
            <input type=text id="name_input" placeholder="Enter your name" disabled>
            <input type="submit" id="connect_button" value="Let's chat!" class="btn btn-primary">
        </form>


      </div>

  <div id="chat">

        <div id="chatbox"></div>
        <form id="message_form">
            <input type=text id="message_input" disabled>
            <input type="submit" id="send_button" value="Send" class="btn btn-primary" disabled>
        </form>
  </div>

  <div id="panes">
    <div id="unassigned" class="pane">
      <h1>New tasks</h1>
    </div>
  </div>

  <div id="key">
    <p><strong>Special commands:</strong></p>
    <p><b>n</b>ew task <span>write proposal</span></p>
    <p><b>s</b>tarting <span>5</span></p>
    <p><b>f</b>inished <span>1</span></p>

  </div>

  <div id="corner">
    <img src="logo.png" width=150 />
    <p>Logged in as <span class="name"></span> in group <span class="group"></span></p>
  </div>


</body>

</html>