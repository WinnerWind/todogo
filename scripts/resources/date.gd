extends Resource
class_name CalendarDate

@export var year:int = 2026
@export_enum("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec") var month:int = 0
var month_number: 
	get: return month+1
@export_range(1,31) var day:int

enum DaysOfTheWeek {MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY}

static func get_today() -> CalendarDate:
	var date = CalendarDate.new()
	
	var today = Time.get_datetime_dict_from_system()
	
	date.year = today["year"]
	date.month = today["month"]-1
	date.year = today.year
	
	return date

static func is_date_ahead(initial_date:CalendarDate, final_date:CalendarDate) -> bool:
	if initial_date.year > final_date.year: #first date is ahead
		return true
	elif initial_date.year < final_date.year: #second date is ahead
		return false
	else:
		if initial_date.month_number > final_date.month_number:
			return true
		elif initial_date.month_number < final_date.month_number:
			return false
		else:
			return (initial_date.day >= final_date.day)
