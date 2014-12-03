# lib/router.coffee

Router.route "/",
  onBeforeAction: ->
    if Meteor.userId()
      @redirect "/budgets"
    else
      @next()

  action: -> @render "login"

Router.route "/register",
  onBeforeAction: ->
    if Meteor.userId()
      @redirect "/budgets"
    else
      @next()

  action: -> @render "register"

Router.route "/budgets",
  fastRender: true

  onBeforeAction: ->
    if not Meteor.userId()
      @redirect "/"
    else
      @next()

  action: -> @render "budgets"