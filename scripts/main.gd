extends Node
class_name ToDoManager

@export var todos:Array[ToDoResource]

func add_date_expiry_todo(title:String, description:String, expiry:CalendarDate):
	var new := ToDoResource.new()
	new.title = title
	new.description = description
	new.expiry_type = ToDoResource.ExpiryTypes.EXPIRE_ON_DATE
	new.expiry_date = expiry
	todos.append(new)

func add_schedule_expiry_todo(title:String, description:String, expiry_type:ToDoResource.ExpireScheduleTypes, schedule:Array[Variant], months_of_the_year_to_expire:Array[int]):
	var new := ToDoResource.new()
	new.title = title
	new.description = description
	new.expiry_type = ToDoResource.ExpiryTypes.EXPIRE_ON_SCHEDULE
	new.expire_schedule_type = expiry_type
	match expiry_type:
		ToDoResource.ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_MONTH:
			if schedule is Array[int]: 
				new.days_of_the_month_to_expire = schedule
		ToDoResource.ExpireScheduleTypes.ON_THESE_MONTHS_OF_THE_YEAR:
			if schedule is Array[int]: 
				new.months_of_the_year_to_expire = schedule
		ToDoResource.ExpireScheduleTypes.ON_THESE_MONTHS_OF_THE_YEAR_ON_GIVEN_DAYS:
			if schedule is Array[int]:
				new.months_of_the_year_to_expire = months_of_the_year_to_expire
				new.days_of_the_month_to_expire = schedule
		ToDoResource.ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_YEAR:
			if schedule is Array[CalendarDate]:
				new.days_of_the_year_to_expire = schedule
		ToDoResource.ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_WEEK:
			if schedule is Array[CalendarDate.DaysOfTheWeek]:
				new.days_of_the_week_to_expire = schedule
