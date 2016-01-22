@Acts = React.createClass
  getInitialState: ->
    page: 1
    pageCount: @getPageCount(@props.data)
    acts: @props.data
  getDefaultProps: ->
    acts: []
  getPageCount: (acts) ->
    Math.ceil(acts.length / @props.pageSize)
  getPage: (acts) ->
    if @state.page > @getPageCount(acts)
      @state.page - 1
    else
      @state.page
  addAct: (act) ->
    acts = React.addons.update(@state.acts, { $push: [act] })
    @setState acts: acts, pageCount: @getPageCount(acts)
  updateAct: (act, data) ->
    index = @state.acts.indexOf act
    acts = React.addons.update(@state.acts, { $splice: [[index, 1, data]] })
    @replaceState acts: acts, page: @state.page, pageCount: @getPageCount(acts)
  deleteAct: (act) ->
    index = @state.acts.indexOf act
    acts = React.addons.update(@state.acts, { $splice: [[index, 1]] })
    @replaceState acts: acts, pageCount: @getPageCount(acts), page: @getPage(acts)
  changePage: (page) ->
    @setState page: page
  render: ->
    React.DOM.div
      className: 'acts'
      React.DOM.h2
        className: 'title'
        I18n.t('acts.index.title')

      React.createElement ActForm, handleNewAct: @addAct
      React.DOM.hr null
      React.createElement Paginator, page: @state.page, pageCount: @state.pageCount, handlePageClick: @changePage
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
            React.DOM.th null, I18n.t('acts.index.table.title')
            React.DOM.th null, I18n.t('acts.index.table.points')
            React.DOM.th null, I18n.t('acts.index.table.actions')
        React.DOM.tbody null,
          for act in @state.acts.slice(@props.pageSize * (@state.page - 1), @props.pageSize * @state.page)
            React.createElement Act, key: act.id, act: act, handleEditAct: @updateAct, handleDeleteAct: @deleteAct

