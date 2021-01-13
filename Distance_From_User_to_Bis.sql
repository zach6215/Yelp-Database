CREATE OR REPLACE FUNCTION partA(
		dlat FLOAT,
		dlong FLOAT,
		alat FLOAT,
		blat FLOAT)
	RETURNS FLOAT
AS $$
	SELECT (sin(dlat/2) * sin(dlat/2)) +
			(cos(alat) * cos(blat) * sin(dlong/2) * sin(dlong/2));
$$
LANGUAGE SQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION partB(
		aPart FLOAT)
	RETURNS FLOAT
AS $$
	SELECT (2 * atan2(sqrt(aPart), sqrt(1-aPart)));
$$
LANGUAGE SQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION degreesToRadians(
		num FLOAT)
	RETURNS FLOAT
AS $$
	SELECT (num * PI() / 180);
$$
LANGUAGE SQL;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION userDistToBis(
		alat FLOAT,
		along FLOAT,
		blat FLOAT,
		blong FLOAT)
	RETURNS FLOAT
AS $$
	SELECT 3958.754641 * partB(partA(degreesToRadians(blat - alat), degreesToRadians(along - blong),
				degreesToRadians(alat), degreesToRadians(blat)));
$$
LANGUAGE SQL;
