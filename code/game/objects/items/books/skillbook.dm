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
	var/current_user

/obj/item/skillbook/surgery
	name = "Surgery skillbook"

/obj/item/skillbook/surgery/attack_self(mob/living/carbon/human/user)
	if(!ishuman(user))
		return
	if(user.do_actions || !isnull(current_user))
		return
	current_user = user
	user.balloon_alert(user, "Reading...")
	if(!do_after(user, RESIN_SELF_TIME, TRUE, user, BUSY_ICON_MEDICAL))
		current_user = null
		return
	activate_skillbook(user)

/obj/item/skillbook/proc/activate_skillbook(mob/living/carbon/human/user)
	user.visible_message(span_notice("[user]'s fingers twitch, a profound realization hitting them"), span_boldnotice("Seven years of medschool and three years of residency floods your mind... You feel you can do surgery better"))
	user.emote("medic")
	user.set_skills(user.skills.modifyRating(surgery = 1))
	qdel(src)
