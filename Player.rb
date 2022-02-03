class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def prompt
        gets.chomp
    end

end 