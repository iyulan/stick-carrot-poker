@ResultDatepicker = React.createClass
  componentDidMount: ->
    that = @;
    $('#datepicker').datepicker(
      inline: true
      language: I18n.locale
      todayBtn: 'linked'
      todayHighlight: true
      format: 'yyyy-mm-dd'
    ).on('changeDate', (e) ->
      date = $(@).data('datepicker').getFormattedDate('yyyy-mm-dd')
      $.get '/results/data.json', { date: date }, (data) =>
        that.props.selectDate data, date
      , 'JSON'
    )
  render: ->
    React.DOM.div
      id: 'datepicker'
