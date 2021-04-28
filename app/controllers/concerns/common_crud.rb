# require "active_support/concern"

module CommonCrud
  extend ActiveSupport::Concern
  included do

    before_action :set_resource, only: %w[show edit update destroy]

    def index
      results = resource_class.all
      instance_variable_set("@#{plural_resource_name}", results)
      respond_to do |format|
        format.html
      end
    end

    def new
      set_resource(resource_class.new)
    end

    def edit; end

    def show; end

    def create
      set_resource(resource_class.new(resource_params))
      if get_resource.save
        redirect_to send("#{plural_resource_name}_path"), flash: { success: "#{resource_name.titleize} has been created successfully." }
      else
        render :new
      end
    end

    def update
      if get_resource.update(resource_params)
        redirect_to send("#{plural_resource_name}_path"), flash: { success: "#{resource_name.titleize} has been updated successfully." }
      else
        render :edit
      end
    end

    def destroy
      if get_resource && get_resource.destroy
        redirect_to send("#{plural_resource_name}_path"), flash: { success: "#{resource_name.titleize} has been deleted successfully." }
      else
        redirect_to send("#{plural_resource_name}_path"), flash: { error: "No #{resource_name} found!" }
      end
    end

    private

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    def plural_resource_name
      resource_name.pluralize
    end

    def resource_params
      self.send("#{resource_name}_params")
    end

    def set_resource(resource=nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

  end
end
