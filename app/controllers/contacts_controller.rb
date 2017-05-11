class ContactsController < ApplicationController

  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end



  def create
    @contact=Contact.create(contacts_params)
    if @contact.save
    redirect_to root_path, notice: "お問い合わせが完了しました！"
    NoticeMailer.sendmail_contact(@contact).deliver
    else
    render 'new'
    end
  end

  def comfirm
      @contact = Contact.new(contacts_params)
      render :new if @contact.invalid?
  end

  private

    def contacts_params
      params.require(:contact).permit(:title, :email, :content)
    end
  end
