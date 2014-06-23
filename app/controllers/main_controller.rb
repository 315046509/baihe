class MainController < ApplicationController
  def index
    # 最新资讯
    @journalisms = Journalism.order_ct_desc.page(params[:page]).all
    # 经典案例
    @roll = Case.order_ct_desc.page(params[:page]).all
  end
end
