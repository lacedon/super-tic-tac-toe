extends Node

var _emitters: Dictionary = {}
var _listeners: Dictionary = {}

func _logConnection(signalName: String, emitter: Node, method: Callable) -> void:
	prints('EventEmitter:', signalName, 'Connect', emitter, 'to', method)

func _logDisconnection(signalName: String, emitter: Node, method: Callable) -> void:
	prints('EventEmitter:', signalName, 'Disconnect', emitter, 'to', method)

func addEmitter(signalName: String, emitter: Node) -> void:
	if not _emitters.has(signalName): _emitters[signalName] = []

	_emitters[signalName].append(emitter)
	prints('EventEmitter:', signalName, 'Emitter', emitter, 'is registered')

	if not _listeners.has(signalName): return
	for listenerMethod in _listeners[signalName]:
		_logConnection(signalName, emitter, listenerMethod)
		emitter.connect(signalName, listenerMethod)

func removeEmitter(signalName: String, emitter: Node) -> void:
	if not _emitters.has(signalName): return

	var emitterIndex: int = _emitters[signalName].find(emitter)
	if emitterIndex >= 0: _emitters[signalName].pop_at(emitterIndex)

	if !_listeners.has(signalName): return

	for listenerMethod in _listeners[signalName]:
		if emitter.is_connected(signalName, listenerMethod):
			_logDisconnection(signalName, emitter, listenerMethod)
			emitter.disconnect(signalName, listenerMethod)

func addListener(signalName: String, method: Callable) -> void:
	if not _listeners.has(signalName): _listeners[signalName] = []
	_listeners[signalName].append(method)
	prints('EventEmitter:', signalName, 'Listener', method, 'is registered')

	if not _emitters.has(signalName): return
	for emitter in _emitters[signalName]:
		_logConnection(signalName, emitter, method)
		emitter.connect(signalName, method)

func removeListener(signalName: String, method: Callable) -> void:
	if not _listeners.has(signalName): return

	var listenerIndex: int = _listeners[signalName].find(method)
	if listenerIndex >= 0: _listeners[signalName].pop_at(listenerIndex)

	if not _emitters.has(signalName): return

	for emitter in _emitters[signalName]:
		if emitter.is_connected(signalName, method):
			_logDisconnection(signalName, emitter, method)
			emitter.disconnect(signalName, method)
