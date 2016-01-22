@Paginator = React.createClass
  getInitialState: ->
    page: @props.page
  componentWillReceiveProps: (newProps) ->
    if @state.page > newProps.pageCount
      @setState page: newProps.page
  handlePrev: (e) ->
    e.preventDefault()
    if @state.page > 1
      page = @state.page - 1
      @setState page: page
      @props.handlePageClick page
  handleNext: (e) ->
    e.preventDefault()
    if @state.page < @props.pageCount
      page = @state.page + 1
      @setState page: page
      @props.handlePageClick page
  render: ->
    React.DOM.nav
      className: 'nav'
      React.DOM.ul
        className: 'pagination'
        React.DOM.li
          className: "#{if @state.page == 1 then 'disabled' else ''}"
          React.DOM.a
            href: '#'
            className: 'a'
            ariaLabel: 'Previous'
            onClick: @handlePrev
            React.DOM.span
              ariaHidden: 'true'
              className: 'span'
              '<'
        React.DOM.li
          className: "#{if @state.page == @props.pageCount || @props.pageCount == 0 then 'disabled' else ''}"
          React.DOM.a
            href: '#'
            className: 'a'
            ariaLabel: 'Next'
            onClick: @handleNext
            React.DOM.span
              ariaHidden: 'true'
              className: 'span'
              '>'
