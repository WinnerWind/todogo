extends Resource
class_name ToDoResource

@export var title:String
@export_multiline var description:String

@export_subgroup("Expiry")
@export_subgroup("Expiry/Type")
enum ExpiryTypes { EXPIRE_ON_DATE, EXPIRE_ON_SCHEDULE }
@export var expiry_type:ExpiryTypes

enum ExpireScheduleTypes { 
	ON_THESE_DAYS_OF_THE_MONTH, 
	ON_THESE_MONTHS_OF_THE_YEAR, 
	ON_THESE_MONTHS_OF_THE_YEAR_ON_GIVEN_DAYS,
	ON_THESE_DAYS_OF_THE_YEAR, 
	ON_THESE_DAYS_OF_THE_WEEK, 
	 }
@export var expire_schedule_type:ExpireScheduleTypes

@export_subgroup("Expiry")
@export var expired:bool = false
@export_subgroup("Expiry/Schedule")
@export var days_of_the_month_to_expire:Array[int] #use this and months of the year to expire to expire on given days
@export var months_of_the_year_to_expire:Array[int]
@export var days_of_the_year_to_expire:Array[CalendarDate]
@export var days_of_the_week_to_expire:Array[CalendarDate.DaysOfTheWeek]

@export_subgroup("Expiry/Specific Date")
@export var expiry_date:CalendarDate

func _init() -> void:
	expiry_date = CalendarDate.new()

func has_expired_today() -> bool:
	return has_expired_on_date(CalendarDate.get_today())

func has_expired_on_date(date_to_check:CalendarDate) -> bool:
	match expiry_type:
		ExpiryTypes.EXPIRE_ON_DATE:
			return CalendarDate.is_date_ahead(date_to_check,expiry_date) 
		ExpiryTypes.EXPIRE_ON_SCHEDULE:
			match expire_schedule_type:
				ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_MONTH:
					return days_of_the_month_to_expire.has(date_to_check.day)
				ExpireScheduleTypes.ON_THESE_MONTHS_OF_THE_YEAR:
					return months_of_the_year_to_expire.has(date_to_check.month_number)
				ExpireScheduleTypes.ON_THESE_MONTHS_OF_THE_YEAR_ON_GIVEN_DAYS:
					return (months_of_the_year_to_expire.has(date_to_check.month_number) and days_of_the_month_to_expire.has(date_to_check.day))
				ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_YEAR:
					for date in days_of_the_year_to_expire:
						if CalendarDate.are_dates_same(date,date_to_check):
							return true
					return false
				ExpireScheduleTypes.ON_THESE_DAYS_OF_THE_WEEK:
					return days_of_the_week_to_expire.has(date_to_check.day_of_the_week)
				_:
					return false
		_:
			return false

func set_expired_state_on_date(date:CalendarDate) -> void:
	set_expired_state(has_expired_on_date(date))

func set_expired_state(new_state:bool) -> void:
	expired = new_state if expired != true else true #keep it on true even if multiple days pass

func to_dict() -> Dictionary:
	var new:Dictionary[String,Variant] = {}
	new["title"] = title
	new["description"] = description
	

	new["expired"] = expired
	new["expire_schedule_type"] = expire_schedule_type

	new["days_of_the_month_to_expire"] = days_of_the_month_to_expire
	new["months_of_the_year_to_expire"] = months_of_the_year_to_expire
	new["days_of_the_year_to_expire"] = days_of_the_year_to_expire. \
			map(func(date:CalendarDate): return str(date))
	new["days_of_the_week_to_expire"] = days_of_the_week_to_expire

	new["expiry_date"] = expiry_date

	return new
