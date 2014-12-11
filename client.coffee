
if not process.env.WEBSERVER? or not process.env.SERIALPORT?
	console.log 'needs WEBSERVER and SERIALPORT enviroment variables'
	process.exit(1)


{SerialPort} = require('serialport')
arduino = new SerialPort(process.env.SERIALPORT)
socket = require('socket.io-client')(process.env.WEBSERVER)

log = (action) ->
	console.log 'sending #{action} to arduino at', new Date()

socket.on 'connect', ->
	#console.log 'connected!'

socket.on 'open', (data) ->
	log 'open'
	arduino.write('o')
	setTimeout (->
		arduino.write('l')
	), 10000

socket.on 'unlock', (data) ->
	log 'unlock'
	arduino.write('o')

socket.on 'lock', (data) ->
	log 'unlock'
	arduino.write('l')

socket.on 'reconnect', ->
	#console.log 'reconnected'

socket.on 'reconnecting', (n) ->
	#console.log 'reconnecting', n
