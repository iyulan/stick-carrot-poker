@ResultForm = React.createClass
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.date && (@state.act_id != '0')
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/results', { result: @state }, (data) =>
      @props.handleNewResult data
      @setState @getInitialState()
    , 'JSON'
  getInitialState: ->
    date: @props.currentDate
    act_id: '0'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: I18n.t('results.index.form.date')
          name: 'date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.select
          className: 'form-control'
          name: 'act_id'
          value: @state.act_id
          onChange: @handleChange
          React.DOM.option
            key: 0
            value: 0
            I18n.t('results.index.form.act')
          for act in @props.acts
            React.DOM.option
              key: act.id
              value: act.id
              act.title
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        I18n.t('results.index.form.create')
