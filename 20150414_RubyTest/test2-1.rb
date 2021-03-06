class Person
    attr_reader :strength, :cleverness, :name

    def initialize(st, cl, name)
        @strength = st
        @cleverness = cl
        @name = name
    end

    def conpensate_status(vs_person)
        if self.instance_of?(Fighter) && vs_person.instance_of?(Wizard)
            @strength = strength * 0.85
        elsif self.instance_of?(Wizard) && vs_person.instance_of?(Priest)
            @cleverness = cleverness * 0.75
        elsif self.instance_of?(Priest) && vs_person.instance_of?(Fighter)
            @strength = strength * 0.95
            @cleverness = cleverness * 0.90
        end
    end

end

class Fighter < Person
    alias base_strength strength
    def strength
        @strengh = base_strength * 1.5
    end

    alias base_cleverness cleverness
    def cleverness
        @cleverness = base_cleverness * 1.0
    end

end

class Wizard < Person
    alias base_strength strength
    def strength
        @strength * 0.5
    end

    alias base_cleverness cleverness
    def cleverness
        @cleverness * 3.0
    end
end
# 1.Priestクラスを追加する
class Priest < Person
    alias base_strength strength
    def strength
        @strength * 1.0
    end

    alias base_cleverness cleverness
    def cleverness
        @cleverness * 2.0
    end
end

# 2.1対1の対戦機能を実装する

class BattleController
    attr_reader :battle_model, :battle_view
    def initialize(person1, person2)
        @battle_model = BattleModel.new(person1, person2)
        @battle_view = BattleView.new(battle_model)
    end

    def battle
        battle_view.display_start
        battle_model.battle_start
        battle_view.display_result
    end

end

class BattleModel
    attr_reader :person1, :person2, :winner
    def initialize(person1, person2)
        @person1 = person1
        @person2 = person2
    end

    def battle_start 
        person1.conpensate_status(person2)
        person2.conpensate_status(person1)

        if person1.battle_power > person2.battle_power
            return  @winner = person1
        elsif person1.battle_power < person2.battle_power
            return  @winner =  person2
        end
    end
end

class BattleView 
    attr_reader :battle_model
    def initialize(battle_model)
        @battle_model = battle_model
    end

    def display_start
        puts "#{battle_model.person1.name}(#{battle_model.person1.class}) VS #{battle_model.person2.name}(#{battle_model.person2.class})"
    end

    def display_result
        if battle_model.winner
            puts "勝者 : #{battle_model.winner.name}(#{battle_model.winner.class})"
        else
            puts "引き分けです"
        end
    end
end

    person1 = Priest.new(100, 100, "塚本")
    person2 = Wizard.new(100, 100, "菅野")
    battle_controller = BattleController.new(person1, person2)
    battle_controller.battle
