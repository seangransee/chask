channel = undefined
userName = undefined
nameForm = undefined
nameInput = undefined
connectButton = undefined
chatForm = undefined
chatInput = undefined
sendButton = undefined
chatBox = undefined
messageForm = undefined
messageInput = undefined

taskNumber = 0

on_submit_name = (event) ->

  $('#start').fadeOut()

  name = $('#name_input').val()

  $('.name').text(name)
  
  # Check if any name has been entered.
  if name isnt ""
    
    # Store the users name for later.
    userName = name
    
    # Disable name entry, and enable message entry.
    nameInput.disabled = true
    connectButton.disabled = true
    messageInput.disabled = false
    sendButton.disabled = false
    messageInput.focus()
    
    # Subscribe to the chat event queue, to receive all past and future
    # messages.
    add_pane name
    channel.subscribe [
      type: "event_queue"
      name: "users"
    ], 0
    channel.subscribe [
      type: "event_queue"
      name: "chat"
    ], 0
    
    # Send a message announcing the users arrival to all users.

    channel.event_queue "users",
      object:
        new_user: userName

  
  # Prevent the page from auto-refreshing.

  $('#name_form').fadeOut()
  $('#panes').fadeIn()
  $('#chat').fadeIn()
  $('#corner').fadeIn()
  $('#key').fadeIn()

  event.preventDefault()
  false
add_pane = (name) ->
  users = []
  $(".pane").each ->
    users.push $(this).data("username")


  unless name in users
    pane = $(document.createElement("div")).addClass("pane").attr("data-username", name)
    $(pane).append $(document.createElement("h1")).text(name)
    if name is userName
      $(pane).addClass('myself')
    $("#panes").append pane
on_send_message = (event) ->
  
  # Check if any message has been entered.
  if messageInput.value isnt ""
    
    # Send the message to all users.
    channel.event_queue "chat",
      object:
        message: messageInput.value
        user: userName

    
    # Reset the message input box.
    messageInput.value = ""
    messageInput.focus()
  
  # Prevent the page from auto-refreshing.
  event.preventDefault()
  false
connect = ->
  client =
    connect: ->
      
      # Enable name entry.
      nameInput.disabled = connectButton.disabled = false
      nameInput.focus()

    event_queue: (name, event) ->
      if (name is "chat") and (event.object.message)
         
        message = event.object.message 
        user = event.object.user
        # Display the incoming message in the chat box.
        #chatBox.value += "\n"  if chatBox.value isnt ""

        for r in [/^new task*\W/, /^[n]*\W/]

          if message.match(r)
            taskNumber += 1
            splitMessage = message.split(r)
            task = splitMessage[1]
            $('#unassigned').append($(document.createElement("p")).text(taskNumber+". "+splitMessage[1]).attr('data-num', taskNumber).attr('data-task', splitMessage[1]))
            add_to_chat(user+' created task: "'+task+'"', 'newtask')
            return

        for r in [/^starting*\W/, /^[s]*\W/]

          if message.match(r)
            splitMessage = message.split(r)
            num = splitMessage[1]
            task = $('#unassigned p[data-num="'+num+'"]')
            console.log task
            if task.length isnt 0
              taskDesc = $(task).data('task')
              task.remove()
              $('.pane[data-username="'+user+'"]').append(task)
              add_to_chat(user+' started task: "'+taskDesc+'"', 'startedtask')
            else
              break
            return

        for r in [/^finished*\W/, /^[f]*\W/]
          if message.match(r)
            splitMessage = message.split(r)
            num = splitMessage[1]
            task = $('.pane[data-username="'+user+'"] p[data-num="'+num+'"]')
            $(task).addClass('complete')
            if task.length isnt 0
              taskDesc = $(task).data('task')
              task.remove()
              $('.pane[data-username="'+user+'"]').append(task)
              add_to_chat(user+' finished task: "'+taskDesc+'"', 'finishedtask')
            else
              break
            return

        add_to_chat(event.object.user+": "+event.object.message)
        chatBox.value += event.object.user+": "+event.object.message+"\n"
        

      if name is "users"
        add_pane event.object.new_user
        add_to_chat(event.object.new_user+" joined the chat", 'joined')
        #chatBox.value += event.object.new_user+": joined the chat\n"

  new IMO.Channel(client)

getUrlVars = ->
  vars = {}
  parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/g, (m, key, value) ->
    vars[key] = value
  )
  vars

add_to_chat = (text, style) ->
  p = $(document.createElement("p")).text(text).addClass(style)
  $(chatBox).append(p)
  $("#chatbox").prop("scrollHeight")
  chatBox.scrollTop = chatBox.scrollHeight
$ ->
  
  # Map the HTML elements to variables, and set up listeners for form
  # submission.
  nameForm = document.getElementById("name_form")
  nameInput = document.getElementById("name_input")
  connectButton = document.getElementById("connect_button")
  nameForm.onsubmit = on_submit_name
  messageForm = document.getElementById("message_form")
  messageInput = document.getElementById("message_input")
  sendButton = document.getElementById("send_button")
  messageForm.onsubmit = on_send_message
  chatBox = document.getElementById("chatbox")

  urlvars = getUrlVars()
  firstpart = urlvars['ch_id'].split('#')

  $('.group').text(firstpart[0].split('-')[1])

  console.log firstpart[0].split('-')[1]

  #$('#chat').fadeIn()
  #$('#panes').fadeIn()
  
  # Connect to the API channel.
  channel = connect()
  #console.log channel

  #$('#name_input').val('Sean')
  #$('#connect_button').submit()
  #on_submit_name()