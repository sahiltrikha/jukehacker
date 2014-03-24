module PartyRulesHelper

  def getPartyRules(party_id)
    rules = Party.find(party_id).rules
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
    unless banned_item == ""
      if Rule.where(condition: column_to_check, banned_value: banned_item).first.nil?
        rule = Rule.create({condition: column_to_check, banned_value: banned_item})
      else 
        rule = Rule.where(condition: column_to_check, banned_value: banned_item).first
      end
      return rule
    end
  end

end 


