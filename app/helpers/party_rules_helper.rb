module PartyRulesHelper

  def getPartyRules(party_id)
    rules = Rule.where(party_id: party_id)
    @rules_hash = {}
    conditions = rules.map {|rule| rule.condition}
    conditions.uniq!
    conditions.each { |rules| @rules_hash[rules.to_sym]= [] }
    rules.each {|rule| @rules_hash[rule.condition.to_sym].push(rule.banned_value) }
  end 

  def evaluatePartyRules(song, party_id)
    getPartyRules(party_id)

    @song_rejected = @rules_hash.map do 
      |condition,values|
      values.include?(song.instance_eval(condition.to_s)) 
    end 


    @song_rejected = @song_rejected.include?(true)

  end 

  def addRule(column_to_check, banned_item)
    # this eliminates blank fields
    unless banned_item == ""
      # this checks to see if the rule already exists
      if Rule.where(condition: column_to_check, banned_value: banned_item).first.nil?
        # creates a new rule if it does not
        rule = Rule.create({condition: column_to_check, banned_value: banned_item})
      else 
        # applies an existing rule if it does
        rule = Rule.where(condition: column_to_check, banned_value: banned_item).first
      end
      # returns the rule object to be added
      return rule
    end
  end

end 


