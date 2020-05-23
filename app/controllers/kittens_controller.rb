class KittensController < ApplicationController

    def index
        @kittens = Kitten.all
        respond_to do |format|
            format.json{ render json: @kittens }
        end
    end

    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)
        if @kitten.save
            flash[:success] = "Congrats, you've made a new fur-rend!"
            redirect_to kittens_path
        else
            flash[:warning] = "There was a problem saving your kitten :("
            redirect_to new_kitten_path
        end
    end

    def show
        @kitten = Kitten.find(params[:id])

        respond_to do |format|
            format.json{ render json: @kitten }
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])

        if @kitten.update(kitten_params)
            flash[:success] = "Congrats, you updated your kitten!"
            redirect_to kittens_path
        else
            flash[:warning] = "Something went wrong :("
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        @kitten.destroy
        redirect_to kittens_path
    end

    private

        def kitten_params
            params.require(:kitten).permit(:name, :age, :cuteness, :softness)
        end
end
