/*
Skillbooks 	(^◕ᴥ◕^)
*/

/obj/item/skillbook
	name = "skillbook"
	icon = 'icons/obj/items/books.dmi'
	icon_state ="book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL		 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	//This var changes what skill geets changed, see skills.dm in datums for skills
	var/skillToModify = "firearms"
	//This var changes the AMOUNT of positive or negative a book changes the marine
	var/skillAmount = 1
	//This var changes what emote the character screams upon successful read, see emote.dm in carbon/human for emotes
	var/emoteToScream = "warcry"
	//This var changes what the other marines see when you complete reading.
	var/stringToOthers = "Unga see other unga smarter"
	//This var changes what YOU see when finished reading
	var/stringToSelf = "unga feel... something"

/obj/item/skillbook/attack_self(mob/living/carbon/human/user)
	if(!ishuman(user) || user.do_actions)
		return
	user.balloon_alert(user, "Reading...")
	if(!do_after(user, RESIN_SELF_TIME, TRUE, user, BUSY_ICON_MEDICAL))
		return
	activate_skillbook(user)

// This proc activates the skillbook
/obj/item/skillbook/proc/activate_skillbook(mob/living/carbon/human/user, skillToModify, skillAmount)
	user.visible_message(span_notice(stringToOthers), span_boldnotice(stringToSelf))
	user.emote(emoteToScream)
	user.set_skills(user.skills.modifyRating(skillToModify = skillAmount))
	qdel(src)

/obj/item/skillbook/surgery
	name = "Surgery skillbook"
	skillToModify = "surgery"
	emoteToScream = "medic"
	stringToOthers = "The corpsman's fingers twitch, a profound realization hitting them"
	stringToSelf = "Seven years of medschool and three years of residency floods your mind... You feel you can do surgery better"
