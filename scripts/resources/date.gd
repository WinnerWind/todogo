extends Resource
class_name CalendarDate

@export var year:int = 2026
@export_enum("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec") var month:int = 0
var month_number: 
	get: return month+1
@export_range(1,31) var day:int

enum DaysOfTheWeek {MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY}
