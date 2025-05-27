/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/holder

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExaminePanel")
		ui.open()

/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/flavor_text
	var/obscured
	var/name = ""
	var/headshot = ""
	var/ooc_notes = ""
	var/ooc_link = ""
	var/ooc_ghoul_pref = ""
	var/ooc_embrace_pref = ""
	var/ooc_bond_pref = ""
	var/ooc_escalation_pref = ""

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) && (holder_human.head && (holder_human.head.flags_inv & HIDEFACE))

		ooc_notes = holder_human.ooc_notes
		
		if(holder_human?.client?.prefs)
			ooc_embrace_pref = holder_human.client.prefs.ooc_embrace_pref
			ooc_ghoul_pref = holder_human.client.prefs.ooc_ghoul_pref
			ooc_bond_pref = holder_human.client.prefs.ooc_bond_pref
			ooc_link = holder_human.client.prefs.ooc_link
			ooc_escalation_pref = holder_human.client.prefs.ooc_escalation_pref

		//Check if the mob is obscured, then continue to headshot
		if((obscured || !holder_human.dna) && !isobserver(user))
			flavor_text = "Obscured"
			name = "Unknown"
		else
			headshot = holder_human.headshot_link
			flavor_text = holder_human.flavor_text
			name = holder.name

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["flavor_text"] = flavor_text
	data["ooc_notes"] = ooc_notes
	data["headshot"] = headshot
	data["ooc_link"] = ooc_link
	data["ooc_embrace_pref"] = ooc_embrace_pref
	data["ooc_ghoul_pref"] = ooc_ghoul_pref
	data["ooc_bond_pref"] = ooc_bond_pref
	data["ooc_escalation_pref"] = ooc_escalation_pref
	return data
