@Results = React.createClass
  getInitialState: ->
    page: 1
    pageCount: @getPageCount(@props.data)
    results: @props.data
    date: @props.currentDate
  getDefaultProps: ->
    results: []
  getPageCount: (results) ->
    Math.ceil(results.length / @props.pageSize)
  getPage: (results) ->
    if @state.page > @getPageCount(results)
      @state.page - 1
    else
      @state.page
  addResult: (result) ->
    results = React.addons.update(@state.results, { $push: [result] })
    @setState results: results, pageCount: @getPageCount(results)
  updateResult: (result, data) ->
    index = @state.results.indexOf result
    results = React.addons.update(@state.results, { $splice: [[index, 1, data]] })
    @replaceState results: results, page: @state.page, pageCount: @getPageCount(results)
  deleteResult: (result) ->
    index = @state.results.indexOf result
    results = React.addons.update(@state.results, { $splice: [[index, 1]] })
    @replaceState results: results, pageCount: @getPageCount(results), page: @getPage(results)
  changePage: (page) ->
    @setState page: page
  handleSelectDate: (date) ->
    @setState date: date
  render: ->
    React.DOM.div
      className: 'results'
      React.DOM.h2
        className: 'title'
        I18n.t('results.index.title')

      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-md-8'
          React.createElement ResultForm, handleNewResult: @addResult, acts: @props.acts, currentDate: @props.currentDate
        React.DOM.div
          className: 'col-md-4'
          React.createElement ResultDatepicker, selectDate: @handleSelectDate

      React.DOM.hr null

      React.createElement Paginator, page: @state.page, pageCount: @state.pageCount, handlePageClick: @changePage

      React.DOM.table
        className: 'table table-bordered'
        React.DOM.colgroup null,
          React.DOM.col
            width: '30%'
          React.DOM.col
            width: '50%'
          React.DOM.col
            width: '20%'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, I18n.t('results.index.table.date')
            React.DOM.th null, I18n.t('results.index.table.act')
            React.DOM.th null,
        React.DOM.tbody null,
          for result in @state.results.slice(@props.pageSize * (@state.page - 1), @props.pageSize * @state.page)
            React.createElement Result, key: result.id, result: result, acts: @props.acts, handleEditResult: @updateResult, handleDeleteResult: @deleteResult

