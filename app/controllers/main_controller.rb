class MainController < ApplicationController
  def index
    # 最新资讯
    @journalisms = Journalism.order_ct_desc.page(params[:page]).per(15)
    # 经典案例
    @roll = Case.order_ct_desc.page(params[:page]).per(12)
  end
end
