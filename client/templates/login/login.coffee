# client/templates/login/login.coffee

window.Login or= {}

window.Login.validateEmail = (email) ->
  if email is ""
    Session.set "errorMessage", "Error - Email cannot be blank"
    $("#email-group").addClass "has-error"
    $("#email").focus()
    return false

  # prevent malicious
  regex = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
  if not regex.test email
    Session.set "errorMessage", "Error - Invalid email"
    $("#email-group").addClass "has-error"
    $("#email").focus()
    return false

  return true

window.Login.submitForm = ->
  email = $("#email")
  password = $("#password")

  if not Login.validateEmail(email.val()) then return

  Meteor.loginWithPassword email.val(), password.val(), (err) ->
    if err
      Session.set "errorMessage", "Error - #{err.reason}"
      if err.reason is "User not found"
        $("#email-group").addClass "has-error"
        $("#email").focus()
      if err.reason is "Incorrect password"
        $("#password-group").addClass "has-error"
        $("#password").focus()
    else
      Router.go "/budgets"

Template.login.events
  "keydown .form-control": (e) ->
    if e.which isnt 13
      Session.set "errorMessage", ""
      $("#email-group").removeClass "has-error"
      $("#password-group").removeClass "has-error"
    else
      Login.submitForm()

  "click #register": ->
    Router.go "/register"

  "click #login": ->
    Login.submitForm()

Template.login.helpers
  errorMessage: -> Session.get "errorMessage"

Template.login.rendered = ->
  Session.set "errorMessage", ""
  $("#email").focus()