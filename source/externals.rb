require_relative 'prober'

class Externals
  
  def prober
    @prober ||= Prober.new
  end

end
