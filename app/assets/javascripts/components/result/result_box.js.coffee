@ResultBox = React.createClass
  render: ->
    React.DOM.div
      className: "panel panel-#{ if @props.points > 0 then 'success' else 'danger' }"
      React.DOM.div
        className: 'panel-heading'
        React.DOM.div
          className: 'result-box-text'
          I18n.t('results.index.box_title', date: @props.date)
      React.DOM.div
        className: 'panel-body'
        React.DOM.div
          className: 'result-box-text'
          @props.points
