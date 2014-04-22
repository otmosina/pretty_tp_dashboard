class Dashing.Graph3 extends Dashing.Widget

  @accessor 'current', ->
    return @get('displayedValue') if @get('displayedValue')
    points = @get('today')
    if points
      points[points.length - 1].y

  ready: ->
    $node = $(@node)
    $container = $node.parent()
    width =
      Dashing.widget_base_dimensions[0] * $container.data("sizex") +
      Dashing.widget_margins[0] * 2 * ($container.data("sizex") - 1)
    height = Dashing.widget_base_dimensions[1] * $container.data("sizey")
    $node.css('background-color', $node.data("bgcolor"))

    $node.append $("<div class='legend month-ago'>month ago</div>")
    $node.append $("<div class='legend week-ago'>week ago</div>")
    $node.append $("<div class='legend today'>today</div>")

    @graph = new Rickshaw.Graph(
      element: @node
      width: width
      height: height
      renderer: "line"
      series: [
        {data: [{x:0, y:0}]},
        {data: [{x:0, y:0}]},
        {data: [{x:0, y:0}]}
      ]
    )

    @graph.series[0].data = @get('today') if @get('today')
    @graph.series[1].data = @get('week_ago') if @get('week_ago')
    @graph.series[2].data = @get('month_ago') if @get('month_ago')

    x_axis = new Rickshaw.Graph.Axis.X(graph: @graph, tickFormat: @xTickFormat)
    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    if @graph
      @graph.series[0].data = data.today
      @graph.series[1].data = data.week_ago
      @graph.series[2].data = data.month_ago
      @graph.render()

    $node = $(@node)
    now = data.today[data.today.length - 1].y
    week_ago = data.week_ago[data.week_ago.length - 1].y
    if now / week_ago < 0.5
      @alert = window.setInterval((->
        if (new Date()).getMilliseconds() > 500
          $node.css('background-color', '#cd4f39')
        else
          $node.css('background-color', $node.data("bgcolor"))
      ), 500)
    else
      window.clearInterval(@alert)
      $node.css('background-color', $node.data("bgcolor"))

  xTickFormat: (val) ->
    return '' if val == 0
    val = (new Date).getHours() + val - 23
    val = 23 - val if val < 0
    val
