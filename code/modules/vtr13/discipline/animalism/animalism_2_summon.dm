/datum/discipline_power/vtr/animalism/summon
	name = "Summon Small Animals"
	desc = "Elgeon write a description kthx. Summon a cat or rat"
	level = 2
	violates_masquerade = FALSE
	var/list/summon_list = list(
		"rat" = /mob/living/simple_animal/hostile/beastmaster/rat,
		"cat" = /mob/living/simple_animal/hostile/beastmaster/cat)
	var/options_lockout = FALSE //prevents storing activations through the option menu

/datum/discipline_power/vtr/animalism/summon/activate()
	. = ..()
	var/limit = 1 + owner.social + owner.more_companions
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/beast = pick(owner.beastmaster)
		beast.death()
	
	if(!length(owner.beastmaster))
		var/datum/action/beastmaster_stay/stay = new()
		stay.Grant(owner)
		var/datum/action/beastmaster_deaggro/deaggro = new()
		deaggro.Grant(owner)


/datum/discipline_power/vtr/animalism/summon/activate()
	. = ..()
	if(options_lockout)
		return
	options_lockout = TRUE
	var/choice = input(owner, "Choose a creature to summon:", "Creatures")  as null|anything in summon_list
	options_lockout = FALSE
	if(!choice)
		return
	var/mob/living/simple_animal/hostile/beastmaster/picked_summon = new choice(get_turf(owner))
	picked_summon.my_creator = owner
	owner.beastmaster |= picked_summon
	picked_summon.beastmaster = owner

