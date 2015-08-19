class InstrumentSkill < ActiveRecord::Base
    belongs_to :instrument
    LEVEL_ANCHORS = ['Beginner', 'Novice', 'Fair', 'Good', 'Excellent']
end
