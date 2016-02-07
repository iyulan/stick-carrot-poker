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
    if result.date == @state.date
      results = React.addons.update(@state.results, { $push: [result] })
      @setState results: results, pageCount: @getPageCount(results)
  updateResult: (result, data) ->
    index = @state.results.indexOf result
    if data.date == @state.date
      results = React.addons.update(@state.results, { $splice: [[index, 1, data]] })
    else
      results = React.addons.update(@state.results, { $splice: [[index, 1]] })
    @replaceState results: results, page: @state.page, pageCount: @getPageCount(results), date: @state.date
  deleteResult: (result) ->
    index = @state.results.indexOf result
    results = React.addons.update(@state.results, { $splice: [[index, 1]] })
    @replaceState results: results, pageCount: @getPageCount(results), page: @getPage(results), date: @state.date
  changePage: (page) ->
    @setState page: page
  handleSelectDate: (data, date) ->
    @setState results: data, pageCount: @getPageCount(data), page: 1, date: date
  pointsSum: ->
    @state.results.reduce ((prev, curr) ->
      prev + parseInt(curr.points)
    ), 0
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
          React.DOM.div
            className: 'row'
            React.DOM.div
              className: 'col-md-6'
              React.createElement ResultBox, points: @pointsSum(), date: @state.date

        React.DOM.div
          className: 'col-md-4'
          React.createElement ResultDatepicker, selectDate: @handleSelectDate

      React.DOM.hr null

      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'col-md-12'
          React.createElement ResultForm, handleNewResult: @addResult, acts: @props.acts, date: @state.date

      if @state.results.length > 0
        React.createElement Paginator, page: @state.page, pageCount: @state.pageCount, handlePageClick: @changePage

      if @state.results.length > 0
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

