class NetworksController < WebController
  def index
    @networks = Network.all
  end
end
