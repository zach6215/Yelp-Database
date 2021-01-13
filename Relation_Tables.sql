CREATE TABLE UserTable (
	userID VARCHAR(24),
	userName VARCHAR,
	averageStars FLOAT,
	dateJoined DATE,
	numberOfFans INTEGER,
	countOfReviews INTEGER,
	latitude FLOAT,
	longitude FLOAT,
	PRIMARY KEY(userID),
	CONSTRAINT CHK_UserTable CHECK (numberOfFans>=0 AND countOfReviews>=0)
);

CREATE TABLE Friendship (
	userID VARCHAR(24),
	friendID VARCHAR(24),
	PRIMARY KEY(userID, friendID),
	FOREIGN KEY(userID) REFERENCES UserTable(userID),
	FOREIGN KEY(friendID) REFERENCES UserTable(userID)
);

CREATE TABLE Business (
	businessID VARCHAR(24),
	bisName VARCHAR,
	reviewRating FLOAT,
	reviewCount INTEGER,
	numCheckins INTEGER,
	openStatus BIT,
	city VARCHAR,
	stateAddress CHAR(4),
	streetAddress VARCHAR,
	zipCode INTEGER,
	latitude FLOAT,
	longitude FLOAT,
	PRIMARY KEY(businessID),
	CONSTRAINT CHK_busRating CHECK (reviewRating>=0 AND reviewRating<=5),
	CONSTRAINT CHK_busPosVal CHECK (reviewCount>=0)
);

CREATE TABLE Categories (
	businessID VARCHAR(24),
	category VARCHAR,
	PRIMARY KEY(businessID, category),
	FOREIGN KEY(businessID) REFERENCES Business(businessID)
);

CREATE TABLE Checkins (
	businessID VARCHAR(24),
	dayOf VARCHAR(12),
	timeof TIME,
	count INTEGER DEFAULT 1,
	PRIMARY KEY(businessID, dayOf, timeof),
	FOREIGN KEY(businessID) REFERENCES Business(businessID)
);

CREATE TABLE Hours (
	businessID VARCHAR(24),
	dayOf VARCHAR(12),
	openTime TIME,
	closeTime TIME,
	PRIMARY KEY(businessID, dayOf),
	FOREIGN KEY(businessID) REFERENCES Business(businessID)
);

CREATE TABLE Review (
	reviewID VARCHAR(24),
	rating INTEGER,
	reviewText VARCHAR,
	dateOf DATE,
	coolCount INTEGER,
	funnyCount INTEGER,
	usefulCount INTEGER,
	businessID VARCHAR(24) NOT NULL,
	userID VARCHAR(24) NOT NULL,
	PRIMARY KEY(reviewID),
	FOREIGN KEY(businessID) REFERENCES Business(businessID),
	FOREIGN KEY(userID) REFERENCES UserTable(userID),
	CONSTRAINT CHK_ReviewRating CHECK (rating>=0 AND rating<=5),
	CONSTRAINT CHK_PositiveCount CHECK (coolCount>=0 AND funnyCount>=0 AND usefulCount>=0)
);

CREATE TABLE Favorite (
	userID VARCHAR(24),
	businessID VARCHAR(24),
	PRIMARY KEY(userID, businessID),
	FOREIGN KEY(userID) REFERENCES UserTable(userID),
	FOREIGN KEY(businessID) REFERENCES Business(businessID)
);
