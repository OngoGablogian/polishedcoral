Route17_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 41, 42, ROUTE_19, 1
	warp_event 41, 43, ROUTE_19, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
