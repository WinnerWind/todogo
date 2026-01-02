extends Resource
class_name CalendarDate

@export var year:int = 2026
@export_enum("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec") var month:int = 0
var month_number: 
	get: return month+1
@export_range(1,31) var day:int

enum DaysOfTheWeek {SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY}
var day_of_the_week:DaysOfTheWeek:
	get:
		# black magic fckery to get the date
		# tldr magically poof a date time dict
		# and re-get the new date time dict to fetch the weekday
		var dict := Time.get_datetime_dict_from_system()
		print(as_string)
		dict["day"] = day
		dict["month"] = month_number
		dict["year"] = year
		var unix = Time.get_unix_time_from_datetime_dict(dict)
		dict = Time.get_datetime_dict_from_unix_time(unix)
		return dict["weekday"]

var as_string:String:
	get:
		return "%s-%s-%s"%[day,month_number,year]
static func get_today() -> CalendarDate:
	var date = CalendarDate.new()
	
	var today = Time.get_datetime_dict_from_system()
	
	date.year = today["year"]
	date.month = today["month"]-1
	date.day = today["day"]
	
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

static func are_dates_same(first_date:CalendarDate, second_date:CalendarDate) -> bool:
	return (first_date.year == second_date.year) \
	and (first_date.month == second_date.month) \
	and (first_date.day == second_date.day)
