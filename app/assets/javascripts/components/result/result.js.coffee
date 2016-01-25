@Result = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleEdit: (e) ->
    e.preventDefault()
    data =
      act_id: ReactDOM.findDOMNode(@refs.act_id).value
      date: ReactDOM.findDOMNode(@refs.date).value
    $.ajax
      method: 'PUT'
      url: "/results/#{ @props.result.id }"
      dataType: 'JSON'
      data:
        result: data
      success: (data) =>
        @setState edit: false
        @props.handleEditResult @props.result, data
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/results/#{ @props.result.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteResult @props.result
  resultRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.result.date
      React.DOM.td null, @props.result.title
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-xs btn-default'
          id: "edit-result-#{@props.result.id}"
          onClick: @handleToggle
          I18n.t('results.index.table.edit')
        React.DOM.a
          className: 'btn btn-xs btn-danger'
          id: "delete-result-#{@props.result.id}"
          onClick: @handleDelete
          I18n.t('results.index.table.delete')
  resultForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control input-sm'
          id: "result-date-#{@props.result.id}"
          type: 'date'
          defaultValue: @props.result.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.select
          className: 'form-control input-sm'
          id: "result-act-#{@props.result.id}"
          defaultValue: @props.result.act_id
          ref: 'act_id'
          React.DOM.option
            key: 0
            value: 0
            I18n.t('results.index.form.act')
          for act in @props.acts
            React.DOM.option
              key: act.id
              value: act.id
              act.title
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-xs btn-default'
          id: "update-result-#{@props.result.id}"
          onClick: @handleEdit
          I18n.t('results.index.table.update')
        React.DOM.a
          className: 'btn btn-xs btn-danger'
          id: "cancel-result-#{@props.result.id}"
          onClick: @handleToggle
          I18n.t('results.index.table.cancel')
  render: ->
    if @state.edit
      @resultForm()
    else
      @resultRow()
