CREATE OR REPLACE FUNCTION newReviewCount() RETURNS trigger AS '
BEGIN
	UPDATE Business
	SET reviewcount = reviewCount + 1
	WHERE Business.businessID = NEW.businessID;
	RETURN NEW;
END
' LANGUAGE plpgsql;

CREATE TRIGGER newReview
AFTER INSERT ON Review
FOR EACH ROW
EXECUTE PROCEDURE newReviewCount();

---------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION newCheckinCount2() RETURNS trigger AS '
BEGIN
	UPDATE Business
	SET numCheckins = (SELECT SUM(count) FROM Checkins WHERE businessID = NEW.businessID)
	WHERE businessID = NEW.businessID;
	RETURN NEW;
END
' LANGUAGE plpgsql;

CREATE TRIGGER newCheckin2
AFTER INSERT OR UPDATE ON Checkins
FOR EACH ROW
EXECUTE PROCEDURE newCheckinCount2();

-----------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION newReviewRating() RETURNS trigger AS '
BEGIN
	UPDATE Business
	SET reviewRating = 
		(SELECT SUM(Review.rating)
		 FROM Review
		 WHERE Review.businessID = NEW.businessID) / (SELECT COUNT(*)
													  FROM Review
													  WHERE Review.businessID = NEW.businessID)
	WHERE Business.businessID = NEW.businessID;
	RETURN NEW;
END
' LANGUAGE plpgsql;

CREATE TRIGGER newAvgReview
AFTER INSERT ON Review
FOR EACH STATEMENT
EXECUTE PROCEDURE newReviewRating();

--------------------------------------------------------------------------------------
