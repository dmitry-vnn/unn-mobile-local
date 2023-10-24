class UserSessionTokenDto {

	final String token;
	final DateTime startDateTime;

  	final int aliveTimeMinutes;

	UserSessionTokenDto(this.token, {DateTime? startDateTime, this.aliveTimeMinutes = 10}):
			startDateTime = startDateTime ?? DateTime.now();

	factory UserSessionTokenDto.fromJson(Map<String, dynamic> json) {
		return UserSessionTokenDto(
			json["token"],

			startDateTime: DateTime.parse(json["startDateTime"]),
			aliveTimeMinutes: json["aliveTimeMinutes"]
		);
	}

	Map<String, dynamic> toJson() {
		return {
			"token": token,
			"startDateTime": startDateTime.toIso8601String(),
			"aliveTimeMinutes": aliveTimeMinutes,
		};
	}

	bool isAlive() {
		final currentDateTime = DateTime.now();
		final different = currentDateTime.difference(startDateTime);

		return different.inMinutes < aliveTimeMinutes;
	}


}