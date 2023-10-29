extends Resource
class_name ServerSettings

@export var port : int = 5511
@export var dev : bool = true;
@export var key : CryptoKey;
@export var cert : X509Certificate;
