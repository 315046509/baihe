class Admin::ClassicCasesController < Admin::MainController
  layout 'admin'
  before_action :roll_params, :only => [:create]
  before_filter :get_roll, :only => [:destroy]

  def index
    @roll = Case.all.order("id desc").page(params[:page]).per(10)
  end

  def new
    @roll = Case.new
  end

  def create
    if request.post?
      if params[:case]
        avatar = params[:case][:avatar]
        title = params[:case][:title]
        description = params[:case][:description]
        imagename = avatar.original_filename
        avatar.original_filename = Time.now.strftime("%Y%m%d%h%m%s")<<rand(99999).to_s<<imagename[imagename.length-4, 4]
        if !avatar.blank? && !title.blank? && !description.blank? && !question_category_id.blank?
          rc = Case.create(:avatar => avatar, :title => title, :description => description, :question_category_id => question_category_id)
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

  def show
    @roll = Case.find params[:id]
  end


  def edit
    @case = Case.find(params[:id])
  end

  def update
    @job = Case.find(params[:id])
    update_category = @job.update_attributes(
        :title => params[:case][:title],
        :description => params[:case][:description]
    )
    if update_category
      respond_to do |job|
        job.html {
          redirect_to admin_classic_cases_path and return
        }
      end
    end
  end

  def destroy
    @roll = Case.find params[:id]
    Case.deletefile(@roll.id)
    @roll.destroy
    redirect_to admin_classic_cases_path and return
  end

  private
  def get_roll
    @roll = Case.where(:id => params[:id]).first
  end

  def roll_params
    params.require(:case).permit(:avatar, :title, :description)
  end
end
