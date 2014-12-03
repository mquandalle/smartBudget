# client/templates/register/register.coffee

window.Register or= {}

window.Register.validateEmail = (email) ->
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

window.Register.validatePassword = (password, confirmPassword) ->
  if password is ""
    Session.set "errorMessage", "Error - Password cannot be blank"
    $("#password-group").addClass "has-error"
    $("#password").focus()
    return false

  regex = /[0-9]/
  if not regex.test password
    Session.set "errorMessage", "Error - Password must contain at least one number"
    $("#password-group").addClass "has-error"
    $("#password").focus()
    return false

  regex = /[a-z]/
  if not regex.test password
    Session.set "errorMessage", "Error - Password must contain at least one lowercase letter"
    $("#password-group").addClass "has-error"
    $("#password").focus()
    return false

  regex = /[A-Z]/
  if not regex.test password
    Session.set "errorMessage", "Error - Password must contain at least one uppercase letter"
    $("#password-group").addClass "has-error"
    $("#password").focus()
    return false

  if password.length < 6
    Session.set "errorMessage", "Error - Password must be at least six characters long"
    $("#password-group").addClass "has-error"
    $("#password").focus()
    return false

  if confirmPassword is ""
    Session.set "errorMessage", "Error - Password cannot be blank"
    $("#confirm-password-group").addClass "has-error"
    $("#confirm-password").focus()
    return false

  if password isnt confirmPassword
    Session.set "errorMessage", "Error - Passwords must match"
    $("#confirm-password-group").addClass "has-error"
    $("#confirm-password").focus()
    return false

  return true

window.Register.validateFirstName = (name) ->
  if name is ""
    Session.set "errorMessage", "Error - First name cannot be blank"
    $("#first-name-group").addClass "has-error"
    $("#first-name").focus()
    return false

  regex = /[^a-zA-Z\-]/
  if regex.test name
    Session.set "errorMessage", "Error - First name can only contain alphanumeric characters"
    $("#first-name-group").addClass "has-error"
    $("#first-name").focus()
    return false

  return true

window.Register.validateLastName = (name) ->
  if name is ""
    Session.set "errorMessage", "Error - Last name cannot be blank"
    $("#last-name-group").addClass "has-error"
    $("#last-name").focus()
    return false

  regex = /[^a-zA-Z\-]/
  if regex.test name
    Session.set "errorMessage", "Error - Last name can only contain alphanumeric characters"
    $("#last-name-group").addClass "has-error"
    $("#last-name").focus()
    return false

  return true

window.Register.submitForm = ->
  email = $("#email")
  password = $("#password")
  confirmPassword = $("#confirm-password")
  firstName = $("#first-name")
  lastName = $("#last-name")

  if not Register.validateEmail(email.val()) then return
  if not Register.validatePassword(password.val(), confirmPassword.val()) then return
  if not Register.validateFirstName(firstName.val()) then return
  if not Register.validateLastName(lastName.val()) then return

  options =
    email: email.val()
    password: password.val()
    profile:
      firstName: firstName.val()
      lastName: lastName.val()

  Accounts.createUser options, (err) ->
    if err
      Session.set "errorMessage", "Error - #{err.reason}"
      if err.reason is "Email already exists."
        $("#email-group").addClass "has-error"
        $("#email").focus()
    else
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

Template.register.events
  "click #cancel": ->
    Router.go "/"

  "keyup .form-control": (e) ->
    if e.which isnt 13
      Session.set "errorMessage", ""
      $("#email-group").removeClass "has-error"
      $("#password-group").removeClass "has-error"
      $("#confirm-password-group").removeClass "has-error"
      $("#first-name-group").removeClass "has-error"
      $("#last-name-group").removeClass "has-error"
    else
      Register.submitForm()

Template.register.helpers
  errorMessage: -> Session.get "errorMessage"

Template.register.rendered = ->
  Session.set "errorMessage", ""
  $("#email").focus()