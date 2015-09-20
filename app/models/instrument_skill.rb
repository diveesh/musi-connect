class InstrumentSkill < ActiveRecord::Base
    belongs_to :instrument
    LEVEL_ANCHORS = ['Novice', 'Intermediate', 'Advanced', 'Professional']
end
