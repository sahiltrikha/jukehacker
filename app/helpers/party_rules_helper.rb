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
      values.include?(@jukebox_song.instance_eval(condition.to_s)) 
    end 

    @song_rejected = @song_rejected.include?(true)

  end 

  def createRule
  
  end

end 


