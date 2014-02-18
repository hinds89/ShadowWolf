require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FootprintAreasController do

  # This should return the minimal set of attributes required to create a valid
  # FootprintArea. As you add validations to FootprintArea, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "measurement" => "1.5" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FootprintAreasController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all footprint_areas as @footprint_areas" do
      footprint_area = FootprintArea.create! valid_attributes
      get :index, {}, valid_session
      assigns(:footprint_areas).should eq([footprint_area])
    end
  end

  describe "GET show" do
    it "assigns the requested config_project as @config_project" do
      footprint_area = FootprintArea.create! valid_attributes
      get :show, {:id => footprint_area.to_param}, valid_session
      assigns(:config_project).should eq(footprint_area)
    end
  end

  describe "GET new" do
    it "assigns a new config_project as @config_project" do
      get :new, {}, valid_session
      assigns(:config_project).should be_a_new(FootprintArea)
    end
  end

  describe "GET edit" do
    it "assigns the requested config_project as @config_project" do
      footprint_area = FootprintArea.create! valid_attributes
      get :edit, {:id => footprint_area.to_param}, valid_session
      assigns(:config_project).should eq(footprint_area)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FootprintArea" do
        expect {
          post :create, {:config_project => valid_attributes}, valid_session
        }.to change(FootprintArea, :count).by(1)
      end

      it "assigns a newly created config_project as @config_project" do
        post :create, {:config_project => valid_attributes}, valid_session
        assigns(:config_project).should be_a(FootprintArea)
        assigns(:config_project).should be_persisted
      end

      it "redirects to the created config_project" do
        post :create, {:config_project => valid_attributes}, valid_session
        response.should redirect_to(FootprintArea.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved config_project as @config_project" do
        # Trigger the behavior that occurs when invalid params are submitted
        FootprintArea.any_instance.stub(:save).and_return(false)
        post :create, {:config_project => { "measurement" => "invalid value" }}, valid_session
        assigns(:config_project).should be_a_new(FootprintArea)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FootprintArea.any_instance.stub(:save).and_return(false)
        post :create, {:config_project => { "measurement" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested config_project" do
        footprint_area = FootprintArea.create! valid_attributes
        # Assuming there are no other footprint_areas in the database, this
        # specifies that the FootprintArea created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        FootprintArea.any_instance.should_receive(:update).with({ "measurement" => "1.5" })
        put :update, {:id => footprint_area.to_param, :config_project => { "measurement" => "1.5" }}, valid_session
      end

      it "assigns the requested config_project as @config_project" do
        footprint_area = FootprintArea.create! valid_attributes
        put :update, {:id => footprint_area.to_param, :config_project => valid_attributes}, valid_session
        assigns(:config_project).should eq(footprint_area)
      end

      it "redirects to the config_project" do
        footprint_area = FootprintArea.create! valid_attributes
        put :update, {:id => footprint_area.to_param, :config_project => valid_attributes}, valid_session
        response.should redirect_to(footprint_area)
      end
    end

    describe "with invalid params" do
      it "assigns the config_project as @config_project" do
        footprint_area = FootprintArea.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FootprintArea.any_instance.stub(:save).and_return(false)
        put :update, {:id => footprint_area.to_param, :config_project => { "measurement" => "invalid value" }}, valid_session
        assigns(:config_project).should eq(footprint_area)
      end

      it "re-renders the 'edit' template" do
        footprint_area = FootprintArea.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FootprintArea.any_instance.stub(:save).and_return(false)
        put :update, {:id => footprint_area.to_param, :config_project => { "measurement" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested config_project" do
      footprint_area = FootprintArea.create! valid_attributes
      expect {
        delete :destroy, {:id => footprint_area.to_param}, valid_session
      }.to change(FootprintArea, :count).by(-1)
    end

    it "redirects to the footprint_areas list" do
      footprint_area = FootprintArea.create! valid_attributes
      delete :destroy, {:id => footprint_area.to_param}, valid_session
      response.should redirect_to(footprint_areas_url)
    end
  end

end