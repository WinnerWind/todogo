extends Resource
class_name CalendarDate

@export var year:int = 2026
@export_enum("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec") var month:int = 0
var month_number: 
	get: return month+1
	set(new): month =  clampi(new-1,0,11)
@export_range(1,31) var day:int = 1

enum DaysOfTheWeek {SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY}
var day_of_the_week:DaysOfTheWeek:
	get:
		# black magic fckery to get the date
		# tldr magically poof a date time dict
		# and re-get the new date time dict to fetch the weekday
		var dict := Time.get_datetime_dict_from_system()
		dict["day"] = day
		dict["month"] = month_number
		dict["year"] = year
		var unix = Time.get_unix_time_from_datetime_dict(dict)
		dict = Time.get_datetime_dict_from_unix_time(unix)
		return dict["weekday"]

func _to_string() -> String:
	return "%s-%s-%s"%[day,month_number,year]

static func from_string(date:String):
	# assume in format dd-mm-yyyy
	var split:Array[String] = date.split("-")
	var n_day = split[0]
	var n_month = split[1]
	var n_year = split[2]
	return CalendarDate.new(n_day, n_month, n_year)

func _init(new_day:int = 1, new_month_number:int = 1, new_year:int = 2026) -> void:
	day = new_day
	month_number = new_month_number
	year = new_year

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

static func get_days_in_range(start_date:CalendarDate, end_date:CalendarDate) -> Array[CalendarDate]:
	#inclusive of the final date too, for parity reasons
	var days:Array[CalendarDate] = [start_date] #inclusive
	while not CalendarDate.are_dates_same(start_date,end_date):
		var next_day:CalendarDate = CalendarDate.get_day_offset(start_date,1)
		days.append(next_day)
		start_date = next_day
	return days


static func get_day_offset(date:CalendarDate,offset:int)->CalendarDate:
	# Get the next,previous etc. day by adding offset of +1/-1 to a date
	var cal:Calendar.Date = Calendar.Date.new(date.year,date.month_number,date.day)
	cal.add_days(offset)
	#my code uses zero indexed months!!!!! 30 minutes down the drain
	var new_date:CalendarDate = CalendarDate.new(cal.day, cal.month, cal.year)
	return new_date


