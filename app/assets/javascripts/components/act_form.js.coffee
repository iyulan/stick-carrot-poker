@ActForm = React.createClass
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.points
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/acts', { act: @state }, (data) =>
      @props.handleNewAct data
      @setState @getInitialState()
    , 'JSON'
  getInitialState: ->
    title: ''
    points: ''
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: I18n.t('act.index.form.title')
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: I18n.t('act.index.form.points')
          name: 'points'
          value: @state.points
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        I18n.t('act.index.form.create')
