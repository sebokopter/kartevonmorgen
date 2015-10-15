# Copyright (c) 2015 Markus Kohlhase <mail@markus-kohlhase.de>

require './SearchBar.styl'
React     = require "react"
T         = React.PropTypes
Pure      = require "react-addons-pure-render-mixin"

{ MAIN_IDS, NAMES, CSS_CLASSES } = require "../constants/Categories"

{ div, input, button, i, span } = React.DOM

CategoryButtons = React.createClass

  displayName: "CategoryButtons"

  mixins: [ Pure ]

  propTypes:
    active     : T.array
    disabled   : T.bool
    onToggle   : T.func

  render: ->
    { disabled, active, onToggle } = @props
    buttons = for c in MAIN_IDS then do (c) ->
      act = if c in (active or []) then ' active' else ''
      button
        key       : c
        disabled  : disabled
        onClick   : -> onToggle c
        className : "#{CSS_CLASSES[c]} pure-u-1-3#{act}",
        NAMES[c]
    div null, buttons

module.exports = React.createClass

  displayName: "SearchBar"

  mixins: [ PureMixin ]

  propTypes:
    searchText  : T.string
    categories  : T.array
    disabled    : T.bool
    toggleCat   : T.func
    onChange    : T.func
    onEnter     : T.func
    onEscape    : T.func

  onChange: (ev) ->
    return unless (v = ev.target?.value)?
    @props.onChange v

  onKeyUp: (ev) ->
    ev.preventDefault()
    switch ev.key
      when "Escape" then @props.onEscape()
      when "Enter"  then @props.onEnter()

  render: ->

    { categories, disabled, toggleCat, searchText } = @props

    div
      style: { opacity: if disabled then 0.5 else 1 }
      className:"SearchBar pure-g pure-form",
      div className: "search pure-u-11-24 pure-g",
        span
          className: "icon",
          i className: "fa fa-search"
        input
          onChange    : @onChange
          disabled    : disabled
          onKeyUp     : @onKeyUp
          value       : searchText
          className   : "pure-u-1"
          placeholder : "Wonach suchst du?"

      div className: "main-categories pure-u-13-24 pure-g",
        React.createElement CategoryButtons,
          active    : categories
          disabled  : disabled
          onToggle  : toggleCat
