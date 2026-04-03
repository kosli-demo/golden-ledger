require_relative 'app_base'

class App < AppBase

  def initialize(externals)
    super(externals)
  end

   get_json(:prober, :alive?)
   get_json(:prober, :ready?)
   get_json(:prober, :sha)

end
