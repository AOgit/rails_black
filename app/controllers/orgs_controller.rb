class OrgsController < ApplicationController

  def create
  	new_org = Org.create(name: params[:org_name], description: params[:desc], user: User.find(params[:id]))
    if new_org.valid?
      Member.create(user: User.find(params[:id]), org: Org.last) 
      redirect_to :back
    else
      flash[:norg_errors] = new_org.errors.full_messages
      redirect_to :back
    end
  end

  def show_group
  	@org = Org.find(params[:id])
  	@org_id = params[:id]
  end 

  def delete
  	Org.find(params[:id]).destroy
  	redirect_to :back
  end

  def join
    Member.create(user: current_user, org: Org.find(params[:org_id]))
    redirect_to :back
  end

  def leave
  	Member.destroy(Member.select(:id).where(user: current_user, org: Org.find(params[:org_id])))
  	redirect_to :back
  end

end
