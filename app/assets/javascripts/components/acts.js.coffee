@Acts = React.createClass
  addAct: (act) ->
    acts = React.addons.update(@state.acts, { $push: [act] })
    @setState acts: acts
  updateAct: (act, data) ->
    index = @state.acts.indexOf act
    acts = React.addons.update(@state.acts, { $splice: [[index, 1, data]] })
    @replaceState acts: acts
  deleteAct: (act) ->
    index = @state.acts.indexOf act
    acts = React.addons.update(@state.acts, { $splice: [[index, 1]] })
    @replaceState acts: acts
  getInitialState: ->
    acts: @props.data
  getDefaultProps: ->
    acts: []
  render: ->
    React.DOM.div
      className: 'acts'
      React.DOM.h2
        className: 'title'
        I18n.t('act.index.title')
      React.createElement ActForm, handleNewAct: @addAct
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.colgroup null,
          React.DOM.col
            width: '30%'
          React.DOM.col
            width: '20%'
          React.DOM.col
            width: '50%'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, I18n.t('act.index.table.title')
            React.DOM.th null, I18n.t('act.index.table.points')
            React.DOM.th null, I18n.t('act.index.table.actions')
        React.DOM.tbody null,
          for act in @state.acts
            React.createElement Act, key: act.id, act: act, handleEditAct: @updateAct, handleDeleteAct: @deleteAct
