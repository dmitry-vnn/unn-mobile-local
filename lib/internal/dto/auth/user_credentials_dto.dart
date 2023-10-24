class UserCredentialsDto {

	final String login;
	final String password;

	UserCredentialsDto(this.login, this.password);

	factory UserCredentialsDto.fromJson(Map<String, dynamic> json) {
		return UserCredentialsDto(
			json["login"],
			json["password"]
		);
	}

	Map<String, dynamic> toJson() {
		return {
			"login": login,
			"password": password
		};
	}

}
