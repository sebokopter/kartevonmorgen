###
Copyright (c) 2015 Markus Kohlhase <mail@markus-kohlhase.de>
###

React       = require "react"
ReactDOM    = require "react-dom"
App         = require "./components/App"
store       = require "./Store"

{ Provider, connect } = require "react-redux"

if __DEVELOPMENT__
  window.React = React

ConnectedApp = (connect (s) -> s) App

rootElement  = document.querySelector 'body'

# inject the 'dispatch' method and the state
Wrapper = React.createElement Provider, { store }, ->
  React.createElement ConnectedApp

if __DEVTOOLS__
  { DevTools, DebugPanel, LogMonitor } = require 'redux-devtools/lib/react'
  { div } = React.DOM
  X = div null,
    Wrapper
    React.createElement DebugPanel,
      top     : yes
      left    : yes
      bottom  : yes
      key     : "debugPanel",
      React.createElement DevTools, { store, monitor:LogMonitor }
  ReactDOM.render X, rootElement
else
  ReactDOM.render Wrapper, rootElement
