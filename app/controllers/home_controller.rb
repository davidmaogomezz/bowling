class HomeController < ApplicationController
  def index
  end

  def add_player
    #puts"params"
    @number_players = params[:number_players]
    respond_to do |format|
      format.html
      format.js
    end              
  end

  def add_score
    @data = params[:data]
    @line = @data["0"]["line"]
    @score = 0
    indice = 1
    while indice <= 10
      score_frame = 0
      boxOne =  @data["#{indice}"]["boxOne"]
      boxTwo =  @data["#{indice}"]["boxTwo"]
      if boxOne == "x" or boxOne == "X"
        score_frame = 10        
        if @data["#{indice+1}"]["boxOne"] != "x" or @data["#{indice+1}"]["boxOne"] != "X"
          if (@data["#{indice+1}"]["boxOne"].ord >= 49 && @data["#{indice+1}"]["boxOne"].ord <= 57) or (@data["#{indice+1}"]["boxTwo"].ord >= 49 && @data["#{indice+1}"]["boxTwo"].ord <= 57)             
            score_frame = @data["#{indice+1}"]["boxOne"].to_i + @data["#{indice+1}"]["boxTwo"].to_i + score_frame
          end
        end
      end
      if boxTwo == "/"
        score_frame = 10   
      end     
      if ((boxOne != "x" or boxOne != "X") && (boxTwo != "/")) 
        if (boxOne.ord >= 49 && boxOne.ord <= 57) or (boxTwo.ord >= 49 && boxTwo.ord <= 57) 
          score_frame = boxOne.to_i + boxTwo.to_i
        end
      end
      @data["#{indice}"]["result"] = score_frame
      @data["#{indice}"]["result_obtained"] = score_frame
      @score = @score + score_frame  
      if indice >= 2   
        if boxOne != "0" or boxTwo != "0"
          @data["#{indice}"]["result"] = @data["#{indice-1}"]["result"] + @data["#{indice}"]["result"]
        else
          @data["#{indice}"]["result"] = 0
        end
        if @data["#{indice}"]["boxTwo"] == "/"
          if @data["#{indice}"]["boxOne"] == "x" or @data["#{indice}"]["boxOne"] == "X"
            @data["#{indice-1}"]["result"] = @data["#{indice-1}"]["result"] + 10
          else
            @data["#{indice-1}"]["result"] = @data["#{indice-1}"]["result"] + @data["#{indice}"]["boxOne"].to_i
          end 
          if @data["#{indice}"]["boxOne"] != "0" && @data["#{indice}"]["boxTwo"] != "0"
            @data["#{indice}"]["result"] = @data["#{indice-1}"]["result"] + @data["#{indice}"]["result_obtained"]
          end
        end        
      end      
      indice = indice + 1      
    end 
    indice = 1
    while indice <= 10
      if @data["#{indice-1}"]["boxOne"] == "x" or @data["#{indice-1}"]["boxOne"] == "X"
        puts "indice #{indice} x atras"
        2.times do |time|
          next_indice = indice + time
          if next_indice <= 10
            puts "next_indice = #{next_indice}"
            @data["#{indice-1}"]["result"] = @data["#{indice-1}"]["result"] + @data["#{next_indice}"]["result_obtained"]
            @data["#{indice}"]["result"] = @data["#{indice-1}"]["result"] + 10
          else
            puts "No entro"
          end
        end
      end
      indice = indice + 1      
    end
    @data["score"] = @score     
  end
end