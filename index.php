<html>
<head>
  <title>Chask</title>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
  <script src="https://apps.imoapi.com/imo.im/api/2/imoapi-min.js"></script>

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

        <h2>Let's get started!</h2>

        <form id="pickgroup">
          <input type="text" placeholder="Group name" id="groupname" />
          <input type="submit" id="entergroup" value="Enter group" class="btn btn-primary">
        </form>
      </div>

  <script type="text/javascript">

    $(document).ready(function() {

      $('#pickgroup').submit(function(e) {

        e.preventDefault()

        console.log($('#groupname').val());

        groupname = $('#groupname').val();

        url = "imo.php?ch_id=chask-"+groupname;

        window.location.href = url;

        console.log(url);

      });

    });

  </script>



</body>

</html>