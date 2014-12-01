# lib/router.coffee

Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"

Router.route "/",
  action: -> @render "login"