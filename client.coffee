{SerialPort} = require('serialport')
arduino = new SerialPort('/dev/tty.usbmodem1411')

socket = require('socket.io-client')(process.env.WEBSERVER)

socket.on 'connect', ->
	#console.log 'connected!'

socket.on 'unlock', (data) ->
	console.log 'sending unlock to arduino'
	arduino.write('o')
	setTimeout (->
		arduino.write('l')
	), 10000

socket.on 'reconnect', ->
	#console.log 'reconnected'

socket.on 'reconnecting', (n) ->
	#console.log 'reconnecting', n
