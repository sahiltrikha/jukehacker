module PartyRulesHelper

##Step 1:  Get list of all Party Rules
##Step 2:  Evaluate each rule to determine if song is okay

  def getPartyRules(party_id)
    @rules = PartyRules.where(party_id: party_id)

      rules_hash = {}
      conditions = @rules.map {|rule| rule.condition}
      conditions.uniq!
      conditions.each { |rules| rules_hash[rules.to_sym]= [] }
      @rules.each {|rule| conditions[@rules.condition.to_sym].push(@rules.value) }

  end 

  def evaluatePartyRules(song, party_rules)



  end 
