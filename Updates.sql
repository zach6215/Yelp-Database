UPDATE business
SET reviewcount = x.numreviews
FROM (SELECT businessid, COUNT(reviewid) as numreviews
    FROM review
NATURAL JOIN business 
    WHERE businessid IN (SELECT businessid
    FROM business
    WHERE review.businessid = business.businessid)
    GROUP BY businessid,bisname) as x
WHERE business.businessid = x.businessid;

-----------------------------------------------------------------------

UPDATE business
SET numcheckins = y.numcheckins
FROM (SELECT business.businessid, SUM(count) as numcheckins
    FROM business, checkins
    WHERE business.businessid = checkins.businessid
    GROUP BY business.businessid) as y
WHERE business.businessid = y.businessid

-----------------------------------------------------------------------

UPDATE business
SET reviewrating = z.avgreview
FROM
    (SELECT business.businessid, AVG(reviewrating) as avgreview
    FROM business, review
    WHERE business.businessid = review.businessid
    GROUP BY business.businessid) as z
WHERE business.businessid = z.businessid
