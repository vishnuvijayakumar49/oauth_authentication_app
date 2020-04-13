module Widgetable
  extend ActiveSupport::Concern

  def query_visible_widgets
    widget_query = params[:id] == 'visible' ? {kind: 'visible'} : {}
    term_query = params[:term].nil? ? "" : "name ilike '%#{params[:term]}%'"
    Widget.where(widget_query).where(term_query)
  end

  def query_widgets
    user = params[:user_id]
    user_id = user == 'me' ? current_user.id : user
    query_widget_kind = params[:term].nil? ? {} : {kind: params[:term]}
    Widget.where(user_id: user_id).where(query_widget_kind)
  end

end