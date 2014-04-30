
  def add_three_points report_name, series, x, hour_ago
    3.times.each do |s_index|
      y = (Report.fetch_aff_report( report_name, hour_ago+Constant.time_shifts[s_index] )[0] rescue 0)
      series.add_point( s_index, x, y )
    end
  end

  def init_filling series, report_name
    count_columns = Constant.graph_count_columns
    x = 0
    Constant.graph_count_columns.downto(0) do |hour_ago|
      add_three_points report_name, series, x, hour_ago
      x += 1
    end
    return series
  end

  def get_report_last_hour report_name
    last_hour = begin
      Report.fetch_aff_report(report_name, 0 )[1]
    rescue
      puts "wait for mysql come to life!"
      sleep 2
      Report.fetch_aff_report(report_name, 0 )[1]
    end
  end



  report_names = [ :aff_paidbookings, :aff_searches, :wl_searches ]
  series = {}

  puts "start init aff metrics"
  start_time = Time.now.to_i
  threads = []
  report_names.each do |report_name|
    threads << Thread.new(report_name) do |report_name_value|
      series[report_name_value] = init_filling Series.new, report_name_value
    end
  end
  threads.each {|thr| thr.join }
  puts "end init aff metrics for #{Time.now.to_i - start_time} seconds "



  report_names.each do |report_name|
    SCHEDULER.every '10s' do
      last_x = series[report_name].last_x
      last_hour = get_report_last_hour report_name
      Time.now.utc.hour != last_hour ? series[report_name].all_shift : series[report_name].all_pop

      #############loginfo#################
      puts "last_x = "+last_x.to_s
      puts report_name.to_s+ "-->"+series[report_name].get.to_s
      #############loginfo#################
      add_three_points report_name, series[report_name], last_x, 0


      puts series[report_name].get.to_s
      send_event(report_name.to_s, {
        today: series[report_name].get[0][:data],
        week_ago: series[report_name].get[1][:data],
        month_ago: series[report_name].get[2][:data]
      })
    end
  end






