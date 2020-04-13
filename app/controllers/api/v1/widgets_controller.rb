module Api::V1
  class WidgetsController < ApiController
    include Widgetable
    include Response

    before_action :set_widget, only: [:update, :destroy]
    before_action do
      doorkeeper_authorize! :public, :read
    end
    
    def index
      widgets = params[:user_id].nil? ? Widget.all : query_widgets
      json_response(widgets)
    end

    def show
      widget = query_visible_widgets
      json_response(widget)
    end

    def create
      widget = Widget.new(widget_params)
      widget.user = current_user
      if widget.save
        json_response(widget)
      else
        json_response(widget, :unprocessable_entity)
      end
    end

    def update
      if @widget.update(widget_params)
        json_response(widget)
      else
        render json: widget.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @widget.destroy
      json_response(@widget)
    end

    private

    def set_widget
      @widget = Widget.find(params[:id])
    end

    def widget_params
      params.require(:widget).permit(:name, :description, :kind)
    end
  end
end
