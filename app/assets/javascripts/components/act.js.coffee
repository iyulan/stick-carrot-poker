@Act = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: ReactDOM.findDOMNode(@refs.title).value
      points: ReactDOM.findDOMNode(@refs.points).value
    $.ajax
      method: 'PUT'
      url: "/acts/#{ @props.act.id }"
      dataType: 'JSON'
      data:
        act: data
      success: (data) =>
        @setState edit: false
        @props.handleEditAct @props.act, data
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/acts/#{ @props.act.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteAct @props.act
  actRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.act.title
      React.DOM.td null, @props.act.points
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-xs btn-default'
          onClick: @handleToggle
          I18n.t('act.index.table.edit')
        React.DOM.a
          className: 'btn btn-xs btn-danger'
          onClick: @handleDelete
          I18n.t('act.index.table.delete')
  actForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control input-sm'
          type: 'text'
          defaultValue: @props.act.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control input-sm'
          type: 'number'
          defaultValue: @props.act.points
          ref: 'points'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-xs btn-default'
          onClick: @handleEdit
          I18n.t('act.index.table.update')
        React.DOM.a
          className: 'btn btn-xs btn-danger'
          onClick: @handleToggle
          I18n.t('act.index.table.cancel')
  render: ->
    if @state.edit
      @actForm()
    else
      @actRow()
