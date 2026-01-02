extends Resource
class_name ToDoResource

@export var title:String
@export_multiline var description:String

@export_subgroup("Schedule")
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

@export var days_of_the_month_to_expire:Array[int] #use this and months of the year to expire to expire on given days
@export var months_of_the_year_to_expire:Array[int]
@export var days_of_the_year_to_expire:Array[CalendarDate]
@export var days_of_the_week_to_expire:Array[CalendarDate.DaysOfTheWeek]

@export var expiry_date:CalendarDate

func _init() -> void:
	expiry_date = CalendarDate.new()
