
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserEntity extends Object {

	@JsonKey(name: 'accessToken')
	String accessToken;
	@JsonKey(name: 'tokenType')
	String tokenType;
	@JsonKey(name: 'refreshToken')
	String refreshToken;
	@JsonKey(name: 'expiresIn')
	int expiresIn;
	@JsonKey(name: 'scope')
	String scope;
	@JsonKey(name: 'tenantId')
	int tenantId;
	@JsonKey(name: 'license')
	String license;
	@JsonKey(name: 'deptId')
	int deptId;
	@JsonKey(name: 'userId')
	int userId;
	@JsonKey(name: 'username')
	String username;
	@JsonKey(name: 'avatarUrl')
	String avatarUrl;

	UserEntity(
			{this.accessToken,
				this.tokenType,
				this.refreshToken,
				this.expiresIn,
				this.scope,
				this.tenantId,
				this.license,
				this.deptId,
				this.userId,
				this.username,
				this.avatarUrl
			});

	UserEntity.fromJson(Map<String, dynamic> json) {
		accessToken = json['access_token'] as String;
		tokenType = json['token_type'] as String;
		refreshToken = json['refresh_token'] as String;
		expiresIn = json['expires_in'] as int;
		scope = json['scope'] as String;
		tenantId = json['tenant_id'] as int;
		license = json['license'] as String;
		deptId = json['dept_id'] as int;
		userId = json['user_id'] as int;
		username = json['username'] as String;
		avatarUrl = json['avatar_url'] as String;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['access_token'] = this.accessToken;
		data['token_type'] = this.tokenType;
		data['refresh_token'] = this.refreshToken;
		data['expires_in'] = this.expiresIn;
		data['scope'] = this.scope;
		data['tenant_id'] = this.tenantId;
		data['license'] = this.license;
		data['dept_id'] = this.deptId;
		data['user_id'] = this.userId;
		data['username'] = this.username;
		data['avatar_url'] = this.avatarUrl;
		return data;
	}
}
