class AuthsController < ApplicationController
  before_action :set_auth, only: [:show, :edit, :update, :destroy]
  caches_page :show, :new
  # GET /auths
  # GET /auths.json
  def index
    @auths = Auth.all.order(:auth_path)
  end

  # GET /auths/1
  # GET /auths/1.json
  def show
  end

  # GET /auths/new
  def new
    @auth = Auth.new
  end

  # GET /auths/1/edit
  def edit
  end

  # POST /auths
  # POST /auths.json
  def create
    @auth = Auth.new(auth_params)
    respond_to do |format|
      if @auth.save
        #权限保存成功后的操作
        #添加权限的全路径 和 权限级别
        #如果权限是顶级菜单 那么 auth_path = 自己的id
        #@auth.auth_path = @auth.id
        if @auth.auth_pid == 0
          @auth.auth_path = @auth.id
          @auth.auth_level =  0
        else
          #如果权限不是顶级菜单 那么auth_path = 上级的全路径-自己的id
          parent =Auth.find_by_id(@auth.auth_pid)
          @auth.auth_path ="#{parent.auth_path}-#{@auth.id}"
          @auth.auth_level = parent.auth_level + 1
        end
        @auth.save
        format.html { redirect_to @auth, notice: 'Auth was successfully created.' }
        format.json { render :show, status: :created, location: @auth }
      else
        format.html { render :new }
        format.json { render json: @auth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auths/1
  # PATCH/PUT /auths/1.json
  def update
    respond_to do |format|
      if @auth.update(auth_params)
        if @auth.auth_pid == 0
           @auth.auth_path = @auth.id
           @auth.auth_level =  0
        else
          #如果权限不是顶级菜单 那么auth_path = 上级的全路径-自己的id
           parent =Auth.find_by_id(@auth.auth_pid)
           @auth.auth_path ="#{parent.auth_path}-#{@auth.id}"
           @auth.auth_level = parent.auth_level + 1
        end
        @auth.save
        ChangeAuthSon(@auth)
        format.html { redirect_to @auth, notice: 'Auth was successfully updated.' }
        format.json { render :show, status: :ok, location: @auth }
      else
        format.html { render :edit }
        format.json { render json: @auth.errors, status: :unprocessable_entity }
      end
    end
  end


  #更新子权限
  def ChangeAuthSon(auth)
    #判断是否拥有子权限
    sonauth = Auth.where("auth_pid==?",auth.id).all
    if sonauth
      #子权限也根据父权限来进行相应的修改
      sonauth.each do |s|
        s.auth_path = "#{auth.auth_path}-#{s.id}"
        s.auth_level = auth.auth_level + 1
        s.save
        ChangeAuthSon(s)
      end
    end


  end

  # DELETE /auths/1
  # DELETE /auths/1.json
  def destroy

    # sonauth.each do |s|
    #   s.destroy
    # end
    #DeleteSonAuth(@auth)
     @auth.destroy
    respond_to do |format|
      format.html { redirect_to auths_url, notice: 'Auth was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auth
      @auth = Auth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auth_params
      params.require(:auth).permit(:auth_name, :auth_pid, :auth_controller, :auth_action)
    end
end
