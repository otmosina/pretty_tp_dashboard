

  series = Series.new
  i = 0
  Constant.graph_count_columns.downto(0) do |hour_ago|

    3.times.each do |s_index|
      y = (Report.aff_searches( hour_ago+Constant.time_shifts[s_index] )[0] rescue 0)
      series.add_point( s_index, i, y )
    end
    i += 1
  end

  last_hour = Report.aff_searches( 0, report_name )[1] rescue Time.now.utc.hour

  SCHEDULER.every '10s' do
    last_x = series.last_x
    if Time.now.utc.hour != last_hour
      series.all_shift
    else
      series.all_pop
    end

    series.update_x_coord!
    puts "last_x = "+last_x.to_s
    puts series.get.to_s
    last_hour = begin
      Report.aff_searches( 0 )[1]
    rescue
      puts "wait for mysql come to life!"
      sleep 2
      Report.aff_searches( 0 )[1]
    end
    3.times.each do |s_index|
      y = (Report.aff_searches(Constant.time_shifts[s_index] )[0] rescue 0)
      series.add_point( s_index, last_x, y)
    end
    puts series.get.to_s
    send_event("aff_searches_old", series: series.get)

    send_event("aff_searches", {
      today: series.get[0][:data],
      week_ago: series.get[1][:data],
      month_ago: series.get[2][:data]
    })

  end



