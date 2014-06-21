class Admin::JournalismsController < Admin::MainController
  layout 'admin'

  def index
    @journalisms = Journalism.order_ct_desc.page(params[:page]).per(10)
  end

  def new
    @journalism = Journalism.new
  end

  def create
    if request.post?
      if params[:journalism]
        avatar = params[:journalism][:avatar]
        title = params[:journalism][:title]
        descrpiton = params[:journalism][:descrpiton]
        imagename = avatar.original_filename
        avatar.original_filename = Time.now.strftime("%Y%m%d%h%m%s")<<rand(99999).to_s<<imagename[imagename.length-4, 4]
        if !avatar.blank? && !title.blank? && !descrpiton.blank?
          rc = Journalism.create(:avatar => avatar, :title => title, :descrpiton => descrpiton)
          if rc.valid?
          else
            msg = ""
            rc.errors.full_messages.each { |error| msg+= error }
            flash[:error]= msg
            redirect_to :back and return
          end
          redirect_to admin_classic_cases_path and return
        else
          flash[:error_msg]="添加失败，请检查添加项是否有空值！"
          redirect_to :back and return
        end
      end
    end
  end

  def edit
    @journalism = Journalism.find(params[:id])
  end

  def update
    @category = Journalism.find(params[:id])
    update_category = @category.update_attributes(
        :title => params[:journalism][:title],
        :descrpiton => params[:journalism][:descrpiton]
    )
    if update_category
      respond_to do |category|
        category.html {
          redirect_to admin_journalisms_path and return
        }
      end
    end
  end

  def show
    @journalism = Journalism.find params[:id]
  end

  #   删除
  def destroy
    @journalism = Case.find params[:id]
    Case.deletefile(@journalism.id)
    @journalism.destroy
    redirect_to admin_journalisms_path and return
  end
end
