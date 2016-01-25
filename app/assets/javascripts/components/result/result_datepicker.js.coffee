@ResultDatepicker = React.createClass
  componentDidMount: ->
    that = @;
    $('#datepicker').datepicker(
      inline: true
      language: I18n.locale
      todayBtn: 'linked'
      todayHighlight: true
      format: 'yyyy-mm-dd'
    ).on('changeDate', (date) ->
      that.props.selectDate $(@).data('datepicker').getFormattedDate('yyyy-mm-dd')
    )
  render: ->
    React.DOM.div
      id: 'datepicker'
