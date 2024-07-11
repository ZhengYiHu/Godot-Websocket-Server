extends Resource
class_name ServerSettings

@export var port : int = 5511
@export var use_ssl_certificate : bool = false;
@export var key : CryptoKey;
@export var cert : X509Certificate;
